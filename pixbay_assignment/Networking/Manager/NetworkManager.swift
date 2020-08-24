//
//  NetworkManager.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 21/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

enum NetworkEnvironment {
    case development
}

protocol FetcherServiceProtocol {
    
    func get<T: Decodable>(_ route: EndPoint, completion: @escaping (T?, String?) -> ())
    func post<T: Decodable>(_ route: EndPoint, param: HTTPParameters, completion: @escaping (T?, String?) -> ())
}

public typealias HTTPParameters = [String: Any]

struct NetworkManager: FetcherServiceProtocol {
    
    static let environment : NetworkEnvironment = .development
    let router = Router<EndPoint>()
    
    func get<T: Decodable>(_ route: EndPoint, completion: @escaping (T?, String?) -> ()) {
        
        HudView.show()
        router.request(route, method: .get) { (data, response, error) in
            
            HudView.kill()
            guard let responseData = data, error == nil else {
                // Show error through alert
                print(error.debugDescription)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let model = try JSONDecoder().decode(T.self, from: responseData)
                        completion(model, nil)
                    } catch let jsonErr {
                        print("failed to decode, \(jsonErr)")
                        completion(nil, jsonErr.localizedDescription)
                    }
                case .failure(let networkFailureError):
                    print("")
                    completion(nil, networkFailureError)
                }
            }
            
        }
        
    }
    
    func post<T: Decodable>(_ route: EndPoint, param: HTTPParameters, completion: @escaping (T?, String?) -> ()) {
        
        HudView.show()
        router.request(route, method: .post) { (data, response, error) in
            
            HudView.kill()
            guard let responseData = data, error == nil else {
                // Show error through alert
                print(error.debugDescription)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    do {
                        let model = try JSONDecoder().decode(T.self, from: responseData)
                        completion(model, nil)
                    } catch let jsonErr {
                        print("failed to decode, \(jsonErr)")
                        completion(nil, jsonErr.localizedDescription)
                    }
                case .failure(let networkFailureError):
                    print("")
                    completion(nil, networkFailureError)
                }
            }
            
        }
    }
    
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
