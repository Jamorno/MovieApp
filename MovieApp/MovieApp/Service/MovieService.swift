//
//  MovieService.swift
//  MovieApp
//
//  Created by Jamorn Suttipong on 13/1/2568 BE.
//

import Foundation

class MovieService {
    
    lazy var apiKey: String = getApiKey()
    
    //get apiKey
    func getApiKey() -> String {
        if let url = Bundle.main.url(forResource: "API", withExtension: "plist"),
           let data = try? Data(contentsOf: url),
           let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
            return plist["API_KEY"] as? String ?? ""
        }
        return ""
    }
    
    //fetch movie
    func fetchMovie(completion: @escaping([Movie]?) -> Void) {
        
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching movies: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let movie = try JSONDecoder().decode(MovieModel.self, from: data)
                completion(movie.results)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        .resume()
    }
    
    //fetch movie detail
    func fetchMovieDetail(for movieID: Int, completion: @escaping(MovieDetailModel?) -> Void) {
        
        let urlString = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(apiKey)&language=en-US"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                print("Error fetching movie detail \(error.localizedDescription) ")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let movie = try JSONDecoder().decode(MovieDetailModel.self, from: data)
                completion(movie)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        .resume()
    }
}
