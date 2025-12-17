//
//  MovieListPresenter.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import Foundation
import Combine

@MainActor
final class MovieListPresenter: ObservableObject{
    enum ViewState: Equatable{
        case idle
        case loading
        case loaded
        case error(String)
    }
    
    @Published private(set) var movies:[Movie] = []
    @Published private(set) var state:ViewState = .idle
    @Published var query: String = ""
    
    private let interactor: MovieListInteractorProtocol
    private let router: MovieListRouterProtocol
    
    private var page:Int = 1
    private var totalPages:Int = 1
    private var isLoadingMore:Bool  = false
    
    
    init(interactor:MovieListInteractorProtocol, router:MovieListRouterProtocol){
        self.interactor = interactor
        self.router = router
    }
    
    func onAppear(){
        guard movies.isEmpty else {return}
        Task{await refresh() }
    }
    
    func refresh()async {
        page = 1
        totalPages = 1
        state = .loading
        do{
            let res = try await interactor.fetchDiscover(page: page)
            movies = res.results
            totalPages = res.totalPages
            state = .loaded
        }catch{
            state = .error(error.localizedDescription)
        }
    }
    
    func loadMoreINeeded(current movie:Movie){
        guard let last = filteredMovies.last, last.id == movie.id else {return}
        guard !isLoadingMore else {return}
        guard page < totalPages else {return}
        
        isLoadingMore = true
        page += 1
        
        Task{
            do{
                let res = try await interactor.fetchDiscover(page:page)
                movies.append(contentsOf: res.results)
                
            }catch{
                
            }
            isLoadingMore = false
        }
    }
    
    var filteredMovies: [Movie]{
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return movies }
        return movies.filter { $0.title.localizedCaseInsensitiveContains(q) }
    }
    
    func didTapMovie(_ movie:Movie){
        router.navigateToDetail(movieId:movie.id,title:movie.title)
    }
}
