//
//  SettingsViewController.swift
//  Plant-Pal
//
//  Created by Megan Nguyen on 6/11/24.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {

    private let clearCacheButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear Cache", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(clearCacheButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Settings"
        
        view.addSubview(clearCacheButton)
        clearCacheButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            clearCacheButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearCacheButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func clearCacheButtonTapped() {
        if let myPlants = UserDefaults.standard.array(forKey: "MyPlants") as? [[String: Any]] {
            for plant in myPlants {
                // Post a notification to notify ViewPlantController instances to update their button states
                NotificationCenter.default.post(name: Notification.Name("ClearCacheNotification"), object: plant["name"])
            }
        }
        
        // Remove everything from MyPlants
        UserDefaults.standard.removeObject(forKey: "MyPlants")
    }
}
