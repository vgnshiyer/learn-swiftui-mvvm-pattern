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
            FilmDetailView(film: film, favoritesViewModel: favoritesViewModel)
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
        FilmImageView(url: film.image)
            .frame(width: 100, height: 150)
        VStack(alignment: .leading) {
            HStack {
                Text(film.title)
                
                Spacer()
                
                FavoriteButton(filmID: film.id, favoritesViewModel: favoritesViewModel)
            }
            Text("Directed by \(film.director)").font(.caption).foregroundColor(.secondary)
            Text("Released \(film.releaseYear)").font(.caption).foregroundColor(.secondary)
        }
        .padding(.top)
    }
}


#Preview {
    FilmListView(
        films: [Film.example],
        favoritesViewModel: FavoritesViewModel.example
    )
}
