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

//            guard let httpResponse = response as? HTTPURLResponse else {
//                completion(.failure(.unknown("Invalid server response")))
//                return
//            }
//
//            if !(200...299).contains(httpResponse.statusCode) {
//                if let data = data {
//                    do {
//                        let decoder = JSONDecoder()
//                        let plantStatus = try decoder.decode(PlantStatus.self, from: data)
//                        let plantError = PlantError(errorCode: httpResponse.statusCode, errorMessage: plantStatus.status.errorMessage)
//                        completion(.failure(.serverError(plantError)))
//                    } catch {
//                        completion(.failure(.serverError(PlantError(errorCode: httpResponse.statusCode, errorMessage: "Unknown server error"))))
//                    }
//                } else {
//                    completion(.failure(.serverError(PlantError(errorCode: httpResponse.statusCode, errorMessage: "Unknown server error"))))
//                }
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(.unknown("No data returned")))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let plantData = try decoder.decode(PlantArray.self, from: data)
//                completion(.success(plantData.data))
//            } catch {
//                completion(.failure(.decodingError("Error decoding JSON: \(error.localizedDescription)")))
//            }



//class PlantService {
//    static func fetchPlants(with endpoint: Endpoint, completion: @escaping (Result<[Plant], PlantServiceError>)->Void) {
//        guard let request = endpoint.request else {return}
//        
//        URLSession.shared.dataTask(with: request) { data, resp, error in
//            if let error = error {
//                completion(.failure(.unknown("invalid request")))
//                return
//            }
//            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
//                
//                do {
//                    let plantError = try JSONDecoder().decode(PlantError.self, from: data ?? Data())
//                    completion(.failure(.serverError(plantError)))
//                    
//                } catch let err {
//                    completion(.failure(.unknown()))
//                    print(err.localizedDescription)
//                }
//            }
//            if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    let plantData = try decoder.decode(PlantArray.self, from: data)
//                    completion(.success(plantData.data))
//                } catch let err {
//                    completion(.failure(.decodingError()))
//                    print(err.localizedDescription)
//                }
//            } else {
//                completion(.failure(.unknown()))
//            }
//        }.resume()
//    }
    



    //    static let shared = NetworkManager()
//
//    private init() {}
//
//    func fetchPlants(completion: @escaping (Result<[Plant], Error>) -> Void) {
//        guard let url = Endpoint.fetchPlants.url else {
//            completion(.failure(NetworkError.invalidURL))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = Endpoint.fetchPlants.httpMethod
//        request.httpBody = Endpoint.fetchPlants.httpBody
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(NetworkError.invalidData))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let plantResponse = try decoder.decode(PlantResponse.self, from: data)
//                completion(.success(plantResponse.data))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//
//        task.resume()
//    }
//}
//
//enum NetworkError: Error {
//    case invalidURL
//    case invalidData
//}
//
//struct PlantResponse: Codable {
//    let data: [Plant]
//}
//
//struct Plant: Codable {
//    let id: Int
//    let commonName: String?
//    let scientificName: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case commonName = "common_name"
//        case scientificName = "scientific_name"
//    }
//}
