//
//  APIClient.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import Foundation

final class APIClient{
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared){
        self.session = session
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func request<T:Decodable>(_ endpoint: EndPoint, as type:T.Type) async throws -> T{
        let req = try endpoint.urlRequest()
        do{
            let(data, response) = try await session.data(for: req)
            
            guard let http = response as? HTTPURLResponse else{
                throw APIError.invalidResponse
            }
            
            guard(200..<300).contains(http.statusCode) else{
                let body = String(data: data, encoding: .utf8)
                throw APIError.httpError(code: http.statusCode, body: body)
            }
            
            do{
                return try decoder.decode(T.self, from: data)
            }catch{
                throw APIError.decoding(error)
            }
            
        }catch let apiError as APIError{
            throw apiError
        }catch{
            throw APIError.network(error)
        }
    }
}
