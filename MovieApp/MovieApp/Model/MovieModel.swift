//
//  MovieModel.swift
//  MovieApp
//
//  Created by Jamorn Suttipong on 13/1/2568 BE.
//

import Foundation

struct MovieModel: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
    
    var posterUrl: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}
