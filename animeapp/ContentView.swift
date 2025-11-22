//
//  ContentView.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/20/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                MoviesScreen(filmsViewModel: FilmsViewModel())
            }
            Tab("Favorites", systemImage: "heart") {
                FavoritesScreen(filmsViewModel: FilmsViewModel())
            }
            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }
            Tab(role: .search) {
                SearchScreen()
            }
        }
    }
}

#Preview {
    ContentView()
}
