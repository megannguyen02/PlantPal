//
//  ViewControllerViewModel.swift
//  Plant-Pal
//
//  Created by Megan Nguyen on 6/8/24.
//

import Foundation
import UIKit

class ViewControllerViewModel {
    
    var onPlantsUpdated: (()->Void)?
    var onErrorMessage: ((PlantServiceError)->Void)?
    
    private let plantService: PlantService
    
    private(set) var allPlants: [Plant] = [] {
        didSet {
            self.onPlantsUpdated?()
        }
    }
    
    private(set) var filteredPlants: [Plant] = []
    
    init(plantService: PlantService = PlantService()) {
        self.plantService = plantService
        self.fetchPlants()
    }
    
    //    init() {
    ////        self.plantService = plantService
    //        self.fetchPlants
    //    }
    
    public func fetchPlants() {
        let endpoint = Endpoint.fetchPlants
        
        PlantService.fetchPlants(with: endpoint) { [weak self] result in
            switch result {
            case .success(let plants):
                self?.allPlants = plants
                print("DEBUG PRINT:) plants fetched.")
                
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
    
}

extension ViewControllerViewModel {
    
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        self.filteredPlants = allPlants
        
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else {self.onPlantsUpdated?(); return}
            
            self.filteredPlants = self.filteredPlants.filter({
                $0.name.lowercased().contains(searchText)
            })
        }
        self.onPlantsUpdated?()
    }
}
    
//    init() {
//        self.fetchPlants()
//        
//    }
//    
//    public func fetchPlants() {
//        let endpoint = Endpoint.fetchPlants.request
//        
//        PlantService.fetchPlants(with: .fetchPlants) { [weak self] result in
//            switch result {
//            case .success(let plants):
//                self?.plants = plants
//                print("DEBUG PRINT:", "\(plants.count) plants fetched.")
//                
//            case .failure(let error):
//                self?.onErrorMessage?(error)
//            }
//        }
//        
//    }

