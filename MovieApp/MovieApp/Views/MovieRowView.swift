//
//  MovieRowView.swift
//  MovieApp
//
//  Created by Jamorn Suttipong on 13/1/2568 BE.
//

import SwiftUI

struct MovieRowView: View {
    
    @ObservedObject var viewModel: MovieRowViewModel
    
    var body: some View {
        HStack(spacing: 30) {
            AsyncImage(url: viewModel.posterURL) {phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    Rectangle()
                        .frame(width: 100, height: 150)
                        .foregroundStyle(.gray.opacity(0.6))
                        .overlay {
                            ProgressView()
                        }
                }
            }
            .frame(width: 100, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            
            VStack(alignment:.leading, spacing: 10) {
                VStack(alignment: .leading) {
                    Text(viewModel.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text(viewModel.releaseDate)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }
                Text(viewModel.overview)
                    .font(.subheadline)
                    .lineLimit(3)
            }
            .foregroundStyle(.black)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MovieRowView(viewModel: MovieRowViewModel(movie: Movie.mockUpMovie))
}
