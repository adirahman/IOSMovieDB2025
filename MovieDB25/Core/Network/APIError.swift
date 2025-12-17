//
//  APIError.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//

import Foundation

enum APIError:Error,LocalizedError{
    case invalidURL
    case invalidResponse
    case httpError(code: Int,body:String?)
    case decoding(Error)
    case network(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        case let .httpError(code, body):
                    return "HTTP Error \(code). \(body ?? "")"
        case let .decoding(error):
            return "Decoding Error: \(error.localizedDescription)"
        case let .network(error):
            return "Network Error: \(error.localizedDescription)"
        }
    }
}
