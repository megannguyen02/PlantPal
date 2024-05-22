//
//  PlantError.swift
//  Plant-Pal
//
//  Created by Megan Nguyen on 5/30/24.
//

import Foundation

struct PlantStatus: Decodable {
    let status: PlantError
}

struct PlantError: Decodable {
    let errorCode: Int
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}
