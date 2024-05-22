//
//  ViewPlantControllerViewModel.swiftDI
//  Plant-Pal
//
//  Created by Megan Nguyen on 5/29/24.
//

import Foundation
import UIKit

class ViewPlantControllerViewModel {
    let plant: Plant
    var onImageLoaded: ((UIImage) -> Void)?
    
//    let plant: Plant
    
    init(_ plant: Plant){
        self.plant = plant
        self.loadImage()
    }
    
    private func loadImage() {
        
        if let imageUrl = URL(string: self.plant.image) {
            DispatchQueue.global().async { [weak self] in
                if let imageData = try? Data(contentsOf: imageUrl),
                   let plantImg = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.onImageLoaded?(plantImg)
                    }
                }
            }
        }
    }
         
    // MARK: - Computed Properties
    var nameLabel: String {
        return (self.plant.name)
    }
    
    var sciNameLabel: String {
        return "Scientific Name: "
    }
    
    var humidityLabel: String {
        return "Humidity Level: "
    }
//
    var soilMoistureLabel: String {
        return "Soil Moisture Level: "
    }
    
    var uvLabel: String {
        return "Light Level: "
    }
}
