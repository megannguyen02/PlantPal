//
//  HTTP.swift
//  Plant-Pal
//
//  Created by Megan Nguyen on 5/30/24.
//

import Foundation

enum HTTP {
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum Headers {
        
        enum Key: String{
            case contentType = "Content-Type"
            case apiToken = "token"
        }
    }
    
    enum Value: String {
        case applicationJson = "application/json"
    }
}
