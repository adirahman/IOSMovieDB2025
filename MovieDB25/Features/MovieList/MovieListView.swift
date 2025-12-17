//
//  MovieListView.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import SwiftUI

struct MovieListView:View{
    @StateObject var presenter: MovieListPresenter
    
    var body: some View{
        VStack(spacing:12){
            header
            
            switch presenter.state {
            case .idle, .loading:
                ProgressView("loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            case .loaded:
                listContent
                
            case .error(let message):
                VStack(spacing:12){
                    Text("Error")
                        .font(.headline)
                    Text(message)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                    Button("Try Again"){
                        Task { await presenter.refresh()}
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .padding(.horizontal,10)
        .navigationTitle("Discover Movies")
        .navigationBarTitleDisplayMode(.inline)
        .task { presenter.onAppear() }
        .refreshable{ await presenter.refresh()}
    }
    
    private var header: some View {
            VStack(spacing: 10) {
                TextField("Search title...", text: $presenter.query)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.top, 10)
        }
    
    private var listContent: some View {
            List {
                ForEach(presenter.filteredMovies) { movie in
                    Button {
                        presenter.didTapMovie(movie)
                    } label: {
                        HStack(spacing: 12) {
                            AsyncImage(url: ImageURL.poster(path: movie.posterPath, size: "w342")) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView().frame(width: 60, height: 90)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 90)
                                        .clipped()
                                        .cornerRadius(10)
                                case .failure:
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.gray.opacity(0.2))
                                        .frame(width: 60, height: 90)
                                        .overlay(Text("No\nImage").font(.caption).multilineTextAlignment(.center))
                                @unknown default:
                                    EmptyView()
                                }
                            }

                            VStack(alignment: .leading, spacing: 6) {
                                Text(movie.title)
                                    .font(.headline)
                                    .lineLimit(2)

                                if let date = movie.releaseDate, !date.isEmpty {
                                    Text(date)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }

                                if let vote = movie.voteAverage {
                                    Text(String(format: "⭐️ %.1f", vote))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }

                            Spacer()
                        }
                    }
                    .buttonStyle(.plain)
                    .onAppear { presenter.loadMoreINeeded(current: movie) }
                }

                if presenter.query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .listStyle(.plain)
        }
}
