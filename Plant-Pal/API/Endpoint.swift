//
//  Endpoint.swift
//  Plant-Pal
//
//  Created by Megan Nguyen on 5/31/24.
//

import Foundation

enum Endpoint {
    
    case fetchPlants
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
//        request.addValues(for: self)
        return request
    }

    var url: URL? {
        var components = URLComponents(string: Constants.baseURL)
        components?.path = Constants.path
        components?.queryItems = [
            URLQueryItem(name: "token", value: Constants.API_KEY)]
        let url = components?.url
        print("DEBUG: Constructed URL - \(url?.absoluteString ?? "Invalid URL")") 
        return url
    }
    
//    private var path: String {
//        switch self {
//        case .fetchPlants():
//            return url
//        }
//    }
    
//    private var queryItems: [URLQueryItem] {
//      switch self {
//      case .fetchPlants:
//          return [
////              URLQueryItem(name: "page", value: "5"),
//          ]
//      }
//  }
    private var queryItems: [URLQueryItem] {
        var items = [URLQueryItem(name: "token", value: Constants.API_KEY)]
        switch self {
        case .fetchPlants:
            items.append(URLQueryItem(name: "page", value: "7"))
//            items.append(URLQueryItem(name: "page", value: "3"))
        }
        return items
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchPlants:
            return HTTP.Method.get.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchPlants:
            return nil
        }
    }
}
 

extension URLRequest {
    func addingHeaderValues(for endpoint: Endpoint) -> URLRequest {
        var request = self
        request.setValue(HTTP.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
        request.setValue("Bearer \(Constants.API_KEY)", forHTTPHeaderField: HTTP.Headers.Key.apiToken.rawValue)
        return request
    }
}
