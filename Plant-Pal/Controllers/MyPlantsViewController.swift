//
//  MyPlantsViewController.swift
//  Plant-Pal
//
//  Created by Megan Nguyen on 6/11/24.
//

import Foundation

import UIKit

class MyPlantsViewController: UIViewController {

    private var myPlants: [Plant] = []

    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "PlantCell")
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "My Plants"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        loadMyPlants()
    }

    private func loadMyPlants() {
        if let savedPlantsData = UserDefaults.standard.data(forKey: "MyPlants") {
                let decoder = JSONDecoder()
                if let savedPlants = try? decoder.decode([Plant].self, from: savedPlantsData) {
                    myPlants = savedPlants
                }
            }
            tableView.reloadData()
    }
}

extension MyPlantsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPlants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlantCell", for: indexPath)
        let plant = myPlants[indexPath.row]
        cell.textLabel?.text = plant.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedPlant = myPlants[indexPath.row]
            showPlantDetails(for: selectedPlant)
        }
    
    private func showPlantDetails(for plant: Plant) {
            let viewModel = ViewPlantControllerViewModel(plant)
            let viewPlantController = ViewPlantController(viewModel)
            navigationController?.pushViewController(viewPlantController, animated: true)
        }
//    private func showPlantDetails(for plantDict: [String: Any]) {
//        if let data = try? JSONSerialization.data(withJSONObject: plantDict),
//           let plant = try? JSONDecoder().decode(Plant.self, from: data) {
//            let viewModel = ViewPlantControllerViewModel(plant)
//            let viewPlantController = ViewPlantController(viewModel)
//            navigationController?.pushViewController(viewPlantController, animated: true)
//        } else {
//            print("Error decoding plant data")
//        }
//    }
}
