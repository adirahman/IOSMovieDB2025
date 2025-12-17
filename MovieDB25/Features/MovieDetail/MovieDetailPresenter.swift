//
//  MovieDetailPresenter.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import Foundation
import Combine

@MainActor
final class MovieDetailPresenter:ObservableObject{
    enum ViewState: Equatable{
        case idle
        case loading
        case loaded
        case error(String)
    }
    
    @Published private(set) var state:ViewState = .idle
    @Published private(set) var movie:Movie?
    
    private let movieId:Int
    private let interactor:MovieDetailInteractorProtocol
    private let router: MovieDetailRouterProtocol
    
    init(movieId:Int,interactor:MovieDetailInteractorProtocol,router:MovieDetailRouterProtocol){
        self.movieId = movieId
        self.interactor = interactor
        self.router = router
    }
    
    func onAppear() {
        guard movie == nil else {return}
        Task { await load() }
    }
    
    func load() async {
        state = .loading
        do{
            let m  = try await interactor.fetchMovieDetail(movieId:movieId)
            movie = m
            state = .loaded
        }catch{
            state = .error(error.localizedDescription)
        }
    }
    func back(){
        router.back()
    }
}
