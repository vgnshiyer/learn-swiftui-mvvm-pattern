//
//  FilmDetailView.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
//

import SwiftUI

struct FilmDetailView: View {
    
    let film: Film
    
    @State private var filmDetailViewModel = FilmDetailViewModel()
    
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                FilmImageView(url: film.bannerImage)
                    .frame(height: 300)
                    .containerRelativeFrame(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(film.title)
                    
                    Divider()
                    
                    Text("Characters").font(.title3)
                    
                    switch filmDetailViewModel.state {
                    case .idle:
                        EmptyView()
                    case .loading:
                        ProgressView{ Text("Loading...") }
                    case .loaded(let people):
                        ForEach(people) { person in
                            Text(person.name)
                        }
                    case .error(let error):
                        Text(error).foregroundStyle(.pink)
                    }
                }
                .padding()
            }
        }
        .toolbar {
            FavoriteButton(filmID: film.id, favoritesViewModel: favoritesViewModel)
        }
        .task {
            await filmDetailViewModel.fetch(for: film)
        }
    }
}

#Preview {
    NavigationStack {
        FilmDetailView(film: Film.example, favoritesViewModel: FavoritesViewModel.example)
    }
}
