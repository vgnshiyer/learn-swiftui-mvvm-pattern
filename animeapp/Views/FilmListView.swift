//
//  FilmListView.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/21/25.
//

import SwiftUI

struct FilmListView: View {
    
    var films: [Film]

    var body: some View {
        List(films) { film in
            NavigationLink(value: film) {
                HStack {
                    FilmImageView(url: film.image)
                        .frame(width: 100, height: 150)
                    Text(film.title)
                }
            }
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailView(film: film)
        }
    }
}

