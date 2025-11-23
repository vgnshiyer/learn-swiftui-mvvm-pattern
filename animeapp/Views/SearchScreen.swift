//
//  SearchScreen.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
//

import SwiftUI

struct SearchScreen: View {

    @State private var text: String = ""
    @State private var searchViewModel = SearchFilmsViewModel()
    let favoritesViewModel: FavoritesViewModel

    var body: some View {
        NavigationStack {
            VStack {
                switch searchViewModel.state {
                case .idle:
                    Text("Search for films...")
                case .loading:
                    ProgressView()
                case .loaded(let films):
                    FilmListView(
                        films: films,
                        favoritesViewModel: favoritesViewModel
                    )
                case .error(let error):
                    Text("Error: \(error)").foregroundColor(.pink)
                }
            }
            .searchable(text: $text)
            .task(id: text) {

                await searchViewModel.fetch(for: text)
            }
        }
    }
}

#Preview {
    SearchScreen(favoritesViewModel: FavoritesViewModel())
}
