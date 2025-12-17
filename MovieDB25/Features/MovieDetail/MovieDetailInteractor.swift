//
//  MovieDetailInteractor.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import Foundation

protocol MovieDetailInteractorProtocol{
    func fetchMovieDetail(movieId:Int) async throws -> Movie
}

final class MovieDetailInteractor:MovieDetailInteractorProtocol{
    private let api: APIClient
    
    init(api:APIClient){
        self.api = api
    }
    
    func fetchMovieDetail(movieId: Int) async throws -> Movie {
        if APIConfig.tmdbApiKey.isEmpty{
            throw APIError.httpError(code: 401, body: "TMDB_API_KEY is empty. Set Info.plist TMDB_API_KEY.")
        }
        let endPoint = TMDBEndpoint.movieDetail(movieId: movieId)
        return try await api.request(endPoint, as: Movie.self)
    }
}
