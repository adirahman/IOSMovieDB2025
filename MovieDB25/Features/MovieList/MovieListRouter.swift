//
//  MovieListRouter.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import Foundation

protocol MovieListRouterProtocol{
    func navigateToDetail(movieId:Int, title:String)
}

final class MovieListRouter:MovieListRouterProtocol {
    private let appRouter:AppRouter
    
    init(appRouter:AppRouter){
        self.appRouter = appRouter
    }
    
    func navigateToDetail(movieId: Int, title: String) {
        appRouter.push(.movieDetail(movieId: movieId, title: title))
    }
}
