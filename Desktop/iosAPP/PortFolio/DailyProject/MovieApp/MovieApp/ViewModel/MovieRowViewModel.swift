//
//  MovieRowViewModel.swift
//  MovieApp
//
//  Created by Jamorn Suttipong on 13/1/2568 BE.
//

import Foundation

class MovieRowViewModel: ObservableObject {
    
    @Published var title: String
    @Published var overview: String
    @Published var posterURL: URL?
    @Published var releaseDate: String
    
    init(movie: Movie) {
        self.title = movie.title
        self.overview = movie.overview
        self.posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
        self.releaseDate = movie.releaseDate
    }
}

extension Movie {
    static let mockUpMovie = Movie(id: 1, title: "Example Movie",
                            overview: "This is an example overview of a movie for preview purposes.",
                                   posterPath: "/examplePosterPath.jpg", releaseDate: "2025-01-13")
}
