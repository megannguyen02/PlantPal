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
    let soilMoisture: Int
//    let uv: Int
    
    enum CodingKeys: String, CodingKey {
        case image = "image_url"
        case name = "common_name"
        case sciName = "scientific_name"
        case humidity = "atmosphertic_humidity"
        case soilMoisture = "soil_humidity"
//        case uv = "light"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        image = try container.decode(String.self, forKey: .image)
        name = try container.decode(String.self, forKey: .name)
        sciName = try container.decode(String.self, forKey: .sciName)
        humidity = try container.decodeIfPresent(Int.self, forKey: .humidity) ?? 50 // default value
        soilMoisture = try container.decodeIfPresent(Int.self, forKey: .soilMoisture) ?? 50 // default value
    }

    init(image: String, name: String, sciName: String, humidity: Int = 50, soilMoisture: Int = 50) {
        self.image = image
        self.name = name
        self.sciName = sciName
        self.humidity = humidity
        self.soilMoisture = soilMoisture
    }
}

