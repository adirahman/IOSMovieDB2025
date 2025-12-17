//
//  APIConfig.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import Foundation

enum APIConfig{
    static let baseURL = URL(string: "https://api.themoviedb.org/3")!
    
    static var tmdbApiKey: String{
        let key = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String
        return key ?? ""
    }
    
    static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p")
    static let defaultLanguage = "en-US"
}
