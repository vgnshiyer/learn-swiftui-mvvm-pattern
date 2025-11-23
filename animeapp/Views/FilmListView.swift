//
//  FilmListView.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/21/25.
//

import SwiftUI

struct FilmListView: View {
    
    let films: [Film]
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        List(films) { film in
            NavigationLink(value: film) {
                FilmRow(film: film, favoritesViewModel: favoritesViewModel)
            }
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailView(film: film)
        }
    }
}

struct FilmRow: View {
    
    let film: Film
    let favoritesViewModel: FavoritesViewModel
    
    var isFavorite: Bool {
        favoritesViewModel.isFavorite(filmID: film.id)
    }
    
    var body: some View {
        HStack {
            FilmImageView(url: film.image)
                .frame(width: 100, height: 150)
            Text(film.title)
            
            Spacer()
            
            Button {
                favoritesViewModel.toggleFavorite(filmID: film.id)
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(isFavorite ? Color.pink : Color.gray)
            }
            .buttonStyle(.plain)
        }
    }
}
