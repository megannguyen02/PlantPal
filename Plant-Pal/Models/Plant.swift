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
//    let sciName: String
//    let humidity: Int
//    let soilMoisture: Int
//    let uv: Int
    
    enum CodingKeys: String, CodingKey {
        case image = "image_url"
        case name = "common_name"
//        case sciName = "scientific_name"
//        case humidity = "atmosphertic_humidity"
//        case soilMoisture = "soil_humidity"
//        case uv = "light"
    }
}

//extension Plant {
//    public static func getMockArray() -> [Plant] {
//        return [
//            Plant(image_url: "https://d2seqvvyy3b8p2.cloudfront.net/40ab8e7cdddbe3e78a581b84efa4e893.jpg", common_name: "Evergreen oak", atmospheric_humidity: 10, soil_humidity: 50, light: 25),
//            Plant(image_url: "https://bs.plantnet.org/image/o/f8d7d6fe52e36d04f5ad1fc03f46f604d5c3cc43", common_name: "Narrow-leaf plantain", atmospheric_humidity: 80, soil_humidity: 75, light: 40),
//            Plant(image_url: "https://bs.plantnet.org/image/o/f84a7d4fc2e627ccd451f568479b1932c2b2d900", common_name: "Barnyard grass", atmospheric_humidity: 80, soil_humidity: 75, light: 40)
//        ]
//    }
//}
