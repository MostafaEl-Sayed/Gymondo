//
//  APIError.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import Foundation

enum APIError: LocalizedError {
    
    case generalError
    case noInternet
    
    var errorDescription: String? {
        switch self {
        case .generalError:
            return "Something went wrong\nPlease try again."
        case .noInternet:
            return "No internet connection\nPlease try again."
        }
    }
}
