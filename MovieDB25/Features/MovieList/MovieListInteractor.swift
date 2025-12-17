//
//  MovieListInteractor.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import Foundation

protocol MovieListInteractorProtocol{
    func fetchDiscover(page:Int) async throws -> PagedResponse<Movie>
}

final class MovieListInteractor: MovieListInteractorProtocol{
    private let api:APIClient
    
    init(api:APIClient){
        self.api = api
    }
    
    func fetchDiscover(page: Int) async throws -> PagedResponse<Movie> {
        if APIConfig.tmdbApiKey.isEmpty{
            throw APIError.httpError(code: 401, body:"TMDB_API_KEY is empty. Set Info.plist TMDB_API_KEY.")
        }
        let endPoint = TMDBEndpoint.discoverMovies(page: page)
        return try await api.request(endPoint,as: PagedResponse<Movie>.self)
    }
}
