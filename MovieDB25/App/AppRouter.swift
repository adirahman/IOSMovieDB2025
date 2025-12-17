//
//  AppRouter.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import SwiftUI
import Combine


enum AppRoute: Hashable {
    case movieDetail(movieId: Int, title: String)
}

@MainActor
final class AppRouter: ObservableObject {
    @Published var path = NavigationPath()

    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path = NavigationPath()
    }
}
