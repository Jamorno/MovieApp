//
//  HomeView.swift
//  MovieApp
//
//  Created by Jamorn Suttipong on 13/1/2568 BE.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarView(searchText: $viewModel.searchText)
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack {
                            ForEach(viewModel.filterMovie, id: \.title) {movie in
                                NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                                    MovieRowView(viewModel: MovieRowViewModel(movie: movie))
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Movie")
            .onAppear {
                viewModel.fetchMovies()
            }
        }
    }
}

#Preview {
    HomeView()
}
