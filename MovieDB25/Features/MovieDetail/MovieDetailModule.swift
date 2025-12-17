//
//  MovieDetailModule.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import SwiftUI

enum MovieDetailModule {
    static func build(appRouter: AppRouter, movieId: Int, title: String) -> some View {
        let api = APIClient()
        let interactor = MovieDetailInteractor(api: api)
        let router = MovieDetailRouter(appRouter: appRouter)
        let presenter = MovieDetailPresenter(movieId: movieId, interactor: interactor, router: router)
        return MovieDetailView(presenter: presenter, title: title)
    }
}
