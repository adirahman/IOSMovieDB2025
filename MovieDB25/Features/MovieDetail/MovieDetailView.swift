//
//  MovieDetailView.swift
//  MovieDB25
//
//  Created by adira on 17/12/25.
//
import SwiftUI

struct MovieDetailView: View {
    @StateObject var presenter: MovieDetailPresenter
    let title: String

    var body: some View {
        VStack {
            switch presenter.state {
            case .idle, .loading:
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .error(let message):
                VStack(spacing: 12) {
                    Text("Error")
                        .font(.headline)
                    Text(message)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 12) {
                        Button("Back") { presenter.back() }
                        Button("Retry") { Task { await presenter.load() } }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .loaded:
                content
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .task { presenter.onAppear() }
    }

    private var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                if let m = presenter.movie {
                    AsyncImage(url: ImageURL.poster(path: m.posterPath, size: "w500")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView().frame(height: 260)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 260)
                                .clipped()
                                .cornerRadius(16)
                        case .failure:
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.gray.opacity(0.2))
                                .frame(height: 260)
                                .overlay(Text("No Image"))
                        @unknown default:
                            EmptyView()
                        }
                    }

                    Text(m.title)
                        .font(.title2).bold()

                    HStack(spacing: 12) {
                        if let date = m.releaseDate, !date.isEmpty {
                            Text("Release: \(date)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        if let vote = m.voteAverage {
                            Text(String(format: "⭐️ %.1f", vote))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }

                    if let overview = m.overview, !overview.isEmpty {
                        Text(overview)
                            .font(.body)
                    } else {
                        Text("No overview.")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(16)
        }
    }
}
