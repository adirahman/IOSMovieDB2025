//
//  TMDBEndpoint.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import Foundation

enum TMDBEndpoint{
    static func discoverMovies(page:Int) -> EndPoint{
        EndPoint(
            path: "discover/movie",
            queryItems: [
                URLQueryItem(name: "api_key", value: APIConfig.tmdbApiKey),
                URLQueryItem(name:"language", value: APIConfig.defaultLanguage),
                URLQueryItem(name:"page", value:String(page))
            ]
        )
    }
    
    static func movieDetail(movieId:Int) -> EndPoint{
        EndPoint(
            path: "movie/\(movieId)",
            queryItems: [
                URLQueryItem(name: "api_key", value: APIConfig.tmdbApiKey),
                URLQueryItem(name:"language", value: APIConfig.defaultLanguage)
            ]
        )
    }
}
