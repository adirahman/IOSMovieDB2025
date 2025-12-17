//
//  MovieDB25App.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//

import SwiftUI

@main
struct MovieDB25App: App {
    @StateObject private var appRouter = AppRouter()
    
    var body: some Scene {
            WindowGroup {
                NavigationStack(path: $appRouter.path) {
                    MovieListModule.build(appRouter: appRouter)
                        .navigationDestination(for: AppRoute.self) { route in
                            switch route {
                            case let .movieDetail(movieId, title):
                                MovieDetailModule.build(
                                    appRouter: appRouter,
                                    movieId: movieId,
                                    title: title
                                )
                            }
                        }
                }
            }
        }
}
