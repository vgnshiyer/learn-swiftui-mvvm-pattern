//
//  MoviesScreen.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
//

import SwiftUI

struct MoviesScreen: View {
    
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel

    var body: some View {
        NavigationStack {
            Group {
                switch filmsViewModel.state {
                case .idle:
                    Text("No Films loaded yet.")
                case .loading:
                    ProgressView { Text("Loading...") }
                case .loaded(let films):
                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                case .error(let error):
                    Text(error).foregroundStyle(.pink)
                }
            }
            .navigationTitle("Ghibli Movies")
        }
        .task {
            await filmsViewModel.fetch()
        }
    }
}

#Preview {
    MoviesScreen(
        filmsViewModel: FilmsViewModel.example,
        favoritesViewModel: FavoritesViewModel.example
    )
}
