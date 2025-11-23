//
//  FavoritesScreen.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
//

import SwiftUI

struct FavoritesScreen: View {

    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel

    var films: [Film] {
        // TODO: get favs
        // retrieve ids from storage
        // get data for favorite ids from films data
        return []
    }

    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView(
                        "No Favorites added yet",
                        systemImage: "heart"
                    )
                } else {
                    FilmListView(
                        films: films,
                        favoritesViewModel: favoritesViewModel
                    )
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesScreen(
        filmsViewModel: FilmsViewModel(service: MockGhibliService()),
        favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage())
    )
}
