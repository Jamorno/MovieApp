//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Jamorn Suttipong on 14/1/2568 BE.
//

import SwiftUI

struct MovieDetailView: View {
    
    @StateObject var viewModel: MovieDetailViewModel
    
    init(movieID: Int) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieID: movieID))
    }
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    } else if let detail = viewModel.movieDetail {
                        
                        //poster image
                        VStack(alignment: .leading, spacing: 10) {
                            AsyncImage(url: detail.posterUrl) {phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Rectangle()
                                        .foregroundStyle(.gray.opacity(0.6))
                                        .overlay {
                                            ProgressView()
                                        }
                                }
                            }
                            
                            //title
                            Text(detail.title)
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            //tagline
                            Text("'\(detail.tagline)'")
                                .font(.headline)
                            
                            HStack {
                                Text(detail.releaseDate)
                                Text("Runtime: \(detail.runtime) min")
                                
                                Spacer()
                                
                                HStack {
                                    Image(systemName: "star.fill")
                                    Text("\(detail.voteAverage, specifier: "%.2f")")
                                }
                            }
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            
                            Divider()
                            
                            //overview
                            VStack(alignment: .leading) {
                                Text(detail.overview)
                                    .font(.subheadline)
                                    .padding(.vertical)
                                if let geners = viewModel.movieDetail?.genres {
                                    HStack {
                                        ForEach(geners, id: \.id) {genes in
                                            Text(genes.name)
                                                .font(.headline)
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        Text("Failed to load movie detail")
                    }
                }
            }
        }
        .padding()
        .navigationTitle(viewModel.movieDetail?.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(.black)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MovieDetailView(movieID: 939243)
}
