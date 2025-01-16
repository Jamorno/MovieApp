//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Jamorn Suttipong on 13/1/2568 BE.
//

import Foundation

class MovieViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var filterMovie: [Movie] = []
    
    init() {
        $searchText
            .combineLatest($movies)
            .map {searchText, movies in
                if searchText.isEmpty {
                    return movies
                } else {
                    return movies.filter {
                        $0.title.lowercased().contains(searchText.lowercased())
                    }
                }
            }
            .assign(to: &$filterMovie)
    }
    
    private let movieService = MovieService()
    
    func fetchMovies() {
        isLoading = true
        
        movieService.fetchMovie {[weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let movies = result {
                    self?.movies = movies
                } else {
                    print("Failed to fetch movies")
                }
            }
        }
    }
}
