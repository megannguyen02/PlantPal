//
//  PlantService.swift
//  Plant-Pal
//
//  Created by Megan Nguyen on 6/5/24.
//

import Foundation

enum PlantServiceError: Error {
    case serverError(PlantError)
    case unknown(String = "An unknown error occurred.")
    case decodingError(String = "Error parsing server response.")
}

class PlantService {
        static func fetchPlants(with endpoint: Endpoint, completion: @escaping (Result<[Plant], PlantServiceError>) -> Void) {
    
            guard let request = endpoint.request else { return }
            
            print("DEBUG: Request URL - \(request.url?.absoluteString ?? "Invalid URL")")
    
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.unknown("Network error: \(error.localizedDescription)")))
                    return
                }
                
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                                
                                do {
                                    let plantError = try JSONDecoder().decode(PlantError.self, from: data ?? Data())
                                    completion(.failure(.serverError(plantError)))
                                    
                                } catch {
                                    completion(.failure(.unknown()))
                                    print("Error decoding server error")
                                }
                            }
                            
                            if let data = data {
    //                            let jsonString = String(data: data, encoding: .utf8)
                                
                                do {
                                    let decoder = JSONDecoder()
                                    let plantData = try decoder.decode(PlantArray.self, from: data)
                                    print("Parsed data from API:", plantData)
                                    completion(.success(plantData.data))
                                    
                                } catch let err {
                                    completion(.failure(.decodingError("Error decoding JSON: \(err.localizedDescription)")))
                                    print(PlantArray.self)
                                    print("Error decoding JSON: \(err.localizedDescription)")
                                }
                                
                            } else {
                                completion(.failure(.unknown("No data returned from server")))
                            }
                
            }.resume()
        }
}
