//
//  MovieDetailRouter.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import Foundation

protocol MovieDetailRouterProtocol{
    func back()
}

final class MovieDetailRouter: MovieDetailRouterProtocol {
    private let appRouter: AppRouter
    
    init(appRouter: AppRouter) {
        self.appRouter = appRouter
    }
    
    func back(){
        appRouter.pop()
    }
}
