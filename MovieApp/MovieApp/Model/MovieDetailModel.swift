//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by Jamorn Suttipong on 13/1/2568 BE.
//

import Foundation

struct MovieDetailModel: Codable {
    let title: String
    let tagline: String
    let overview: String
    let posterPath: String
    let runtime: Int
    let releaseDate: String
    let voteAverage: Double
    let genres: [Genres]
    
    enum CodingKeys: String, CodingKey {
        case title
        case tagline
        case overview
        case posterPath = "poster_path"
        case runtime
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case genres
    }
    
    var posterUrl: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}

struct Genres: Codable {
    let id: Int
    let name: String
}
