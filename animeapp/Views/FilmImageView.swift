//
//  FilmImageView.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
//

import SwiftUI

struct FilmImageView: View {
    
    let url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) {
            phase in
            switch phase {
            case .empty:
                Color(white: 0.8)
                    .overlay {
                        ProgressView()
                            .controlSize(.large)
                    }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure(let error): Text("Could not get image \(error)").foregroundStyle(Color.red)
            @unknown default:
                fatalError()
            }
        }
    }
}

#Preview("poster image") {
    FilmImageView(url: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg")
        .frame(height: 150)
}

#Preview("Banner image") {
    FilmImageView(url: "https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg")
        .frame(height: 200)
}
