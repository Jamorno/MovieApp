//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Jamorn Suttipong on 13/1/2568 BE.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    
    @Published var movieDetail: MovieDetailModel?
    @Published var isLoading: Bool = false
    
    private let movieService = MovieService()
    private let movieID: Int
    
    init(movieID: Int) {
        self.movieID = movieID
        fetchMovieDetail(for: movieID)
    }
    
    func fetchMovieDetail(for movieID: Int) {
        isLoading = true
        movieService.fetchMovieDetail(for: movieID) { [weak self] detail in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.movieDetail = detail
            }
        }
    }
}
