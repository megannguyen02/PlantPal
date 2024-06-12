//
//  Plant.swift
//  Plant-Pal
//
//  Created by Megan Nguyen on 5/21/24.
//

import Foundation
import UIKit

struct PlantArray: Decodable {
    let data: [Plant]
}

struct Plant: Codable {
    let image: String
    let name: String
    let sciName: String
    let humidity: Int
//    let temp: Int
    let soilMoisture: Int
    let lightExposure: Int
    
    enum CodingKeys: String, CodingKey {
        case image = "image_url"
        case name = "common_name"
        case sciName = "scientific_name"
        case humidity = "atmosphertic_humidity"
//        case temp = "temperature"
        case soilMoisture = "soil_humidity"
        case lightExposure = "light"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        image = try container.decode(String.self, forKey: .image)
        name = try container.decode(String.self, forKey: .name)
        sciName = try container.decode(String.self, forKey: .sciName)
        humidity = try container.decodeIfPresent(Int.self, forKey: .humidity) ?? 20 // default value
//        temp = try container.decodeIfPresent(Int.self, forKey: .temp) ?? 23
        soilMoisture = try container.decodeIfPresent(Int.self, forKey: .soilMoisture) ?? 2160
        lightExposure = try container.decodeIfPresent(Int.self, forKey: .lightExposure) ?? 3078
    }

//    init(image: String, name: String, sciName: String, humidity: Int = 50, soilMoisture: Int = 50) {
//        self.image = image
//        self.name = name
//        self.sciName = sciName
//        self.humidity = humidity
//        self.soilMoisture = soilMoisture
//    }
}

