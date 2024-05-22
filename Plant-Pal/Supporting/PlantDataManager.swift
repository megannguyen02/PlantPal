//
//  PlantDataManager.swift
//  Plant-Pal
//
//  Created by Megan Nguyen on 6/11/24.
//

import Foundation

class PlantDataManager {
    static let shared = PlantDataManager()
    
    private init() {} // Ensures only one instance of PlantDataManager
    
    // Saving plants to UserDefaults
    func savePlantsToUserDefaults(_ plants: [Plant]) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(plants) {
            UserDefaults.standard.set(encodedData, forKey: "MyPlants")
        } else {
            print("Failed to encode plants.")
        }
    }
    
    // Loading plants from UserDefaults
    func loadPlantsFromUserDefaults() -> [Plant] {
        if let savedPlantsData = UserDefaults.standard.data(forKey: "MyPlants") {
            let decoder = JSONDecoder()
            if let savedPlants = try? decoder.decode([Plant].self, from: savedPlantsData) {
                return savedPlants
            } else {
                print("Failed to decode plants.")
            }
        }
        return []
    }
    
    func addPlant(_ newPlant: Plant) {
            var plants = loadPlantsFromUserDefaults()
            plants.append(newPlant)
            savePlantsToUserDefaults(plants)
        }
}
