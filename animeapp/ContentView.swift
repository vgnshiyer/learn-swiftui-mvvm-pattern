//
//  ContentView.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/20/25.
//

import SwiftUI

struct ContentView: View {

    @State private var filmsViewModel = FilmsViewModel()

    @State private var favoritesViewModel = FavoritesViewModel()

    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                MoviesScreen(
                    filmsViewModel: filmsViewModel,
                    favoritesViewModel: favoritesViewModel
                )
            }
            Tab("Favorites", systemImage: "heart") {
                FavoritesScreen(
                    filmsViewModel: filmsViewModel,
                    favoritesViewModel: favoritesViewModel
                )
            }
            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }
            Tab(role: .search) {
                SearchScreen()
            }
        }
        .task {
            favoritesViewModel.load()
        }
    }
}

#Preview {
    ContentView()
}
