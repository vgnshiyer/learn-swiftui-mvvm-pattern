//
//  FavoriteButton.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/23/25.
//


import SwiftUI

struct FavoriteButton: View {
    let filmID: String
    let favoritesViewModel: FavoritesViewModel
    
    var isFavorite: Bool {
        favoritesViewModel.isFavorite(filmID: filmID)
    }
    
    var body: some View {
        Button {
            favoritesViewModel.toggleFavorite(filmID: filmID)
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? Color.pink : Color.gray)
        }
        .buttonStyle(.plain)
    }
}