//
//  EndPoint.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import Foundation

struct EndPoint{
    let path:String
    let method:String
    let queryItems:[URLQueryItem]
    
    init(path:String, method:String="GET", queryItems:[URLQueryItem] = []){
        self.path = path
        self.method = method
        self.queryItems = queryItems
    }
    
    func urlRequest() throws -> URLRequest{
        // Use URLComponents with a properly joined path to avoid dropping slashes
        guard var comps = URLComponents(url: APIConfig.baseURL, resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }
        comps.path = APIConfig.baseURL.appendingPathComponent(path).path
        comps.queryItems = queryItems
        
        guard let url = comps.url else { throw APIError.invalidURL }
        
        var req = URLRequest(url:url)
        req.httpMethod = method
        return req
    }
}
