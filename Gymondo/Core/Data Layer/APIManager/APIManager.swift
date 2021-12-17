//
//  APIManager.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import UIKit
import Combine

class APIManager: NSObject {
    
    static let shared = APIManager()
    
    private override init() {}
    
    enum HTTPMethodType: String {
        case POST = "POST"
        case GET = "GET"
    }
    
    func requestAPI<T: Decodable>(url: String, parameter: [String: AnyObject]? = nil,
                                  httpMethodType: HTTPMethodType = .GET) -> AnyPublisher<T, APIError> {
        
        guard InternetManager.shared.isInternetConnectionAvailable() else {
            return Fail(error: APIError.noInternet).eraseToAnyPublisher()
        }
        
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard let escapedAddress = encodedUrl, let url = URL(string: escapedAddress) else {
            return Fail(error: APIError.generalError).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethodType.rawValue
        if let params = parameter {
            request.httpBody = try? JSONSerialization
                .data(withJSONObject: params, options: .prettyPrinted)
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.0 }
            .decode(type: T.self, decoder: JSONDecoder())
            .catch { _ in Fail(error: APIError.generalError).eraseToAnyPublisher() }
            .eraseToAnyPublisher()
    }
}
