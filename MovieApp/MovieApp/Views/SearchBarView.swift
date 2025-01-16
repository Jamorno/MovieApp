//
//  SearchBarView.swift
//  MovieApp
//
//  Created by Jamorn Suttipong on 13/1/2568 BE.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
            
            TextField("Search movie", text: $searchText)
                .foregroundStyle(.black)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .overlay {
            Capsule()
                .stroke(lineWidth: 0.5)
                .foregroundStyle(Color(.systemGray4))
                .shadow(color: .black.opacity(0.2), radius: 2)
        }
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
