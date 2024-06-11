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
    
    private let addButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Add Plants", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18)
            button.addTarget(self, action: #selector(addPlantsTapped), for: .touchUpInside)
            return button
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "My Plants"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(addButton)
        view.addSubview(tableView)
                        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        loadMyPlants()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            loadMyPlants() // Reload the plants every time the view appears
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
    
    @objc private func addPlantsTapped() {
        let viewController = ViewController() // Replace with the actual view controller you want to navigate to
        navigationController?.pushViewController(viewController, animated: true)
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
