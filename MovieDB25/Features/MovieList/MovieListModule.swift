//
//  MovieListModule.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import SwiftUI

enum MovieListModule{
    static func build(appRouter: AppRouter) -> some View{
        let api = APIClient()
        let interactor = MovieListInteractor(api: api)
        let router = MovieListRouter(appRouter: appRouter)
        let presenter = MovieListPresenter(interactor: interactor, router: router)
        return MovieListView(presenter: presenter)
    }
}
