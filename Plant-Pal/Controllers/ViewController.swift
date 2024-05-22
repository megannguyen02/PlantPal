//
//  ViewController.swift
//  Plant-Pal
//
//  Created by Megan Nguyen on 5/21/24.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel: ViewControllerViewModel

    //MARK - UI Components
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(PlantCell.self, forCellReuseIdentifier: PlantCell.identifier)
        return tv
    }()
    
//    init(_ viewModel: ViewControllerViewModel = ViewControllerViewModel()){
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    init(viewModel: ViewControllerViewModel = ViewControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = ViewControllerViewModel()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.setupSearchController()
        self.setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.onPlantsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        self.viewModel.fetchPlants()
        self.tableView.reloadData()
    }

    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.tableView.register(PlantCell.self, forCellReuseIdentifier: PlantCell.identifier)

        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    private func setupSearchController(){
        print("DEBUG: Setting up search controller ...")
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Plants"
        
        self.navigationItem.searchController = searchController
        print("DEBUG: Search controller set to navigation item") 
        self.definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// Mark - Search Controller Functions
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("DEBUG PRINT", searchController.searchBar.text ?? "")
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("Number of rows: \(self.viewModel.allPlants.count)")
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        return inSearchMode ? self.viewModel.filteredPlants.count : self.viewModel.allPlants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlantCell.identifier, for: indexPath) as? PlantCell else {
            fatalError("Unable to dequeue PlantCell in ViewController")
        }

        let inSearchMode = self.viewModel.inSearchMode(searchController)
        let plant = inSearchMode ? self.viewModel.filteredPlants[indexPath.row] : self.viewModel.allPlants[indexPath.row]
        
        cell.configure(with: plant)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
//
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        let plant = inSearchMode ? self.viewModel.filteredPlants[indexPath.row] : self.viewModel.allPlants[indexPath.row]
        
        let vm = ViewPlantControllerViewModel(plant)
        let vc = ViewPlantController(vm)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
