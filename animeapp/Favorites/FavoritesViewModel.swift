//
//  FavoritesViewModel.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
//

import Foundation
import Observation

@Observable
class FavoritesViewModel {
    
    private(set) var favoriteIDs: Set<String> = []
    
    private let service: FavoriteStorage
    
    init(service: FavoriteStorage = DefaultFavoriteStorage()) {
        self.service = service
    }
    
    func load() {
        favoriteIDs = service.load()
    }
    
    private func save() {
        service.save(favoriteIDs: favoriteIDs)
    }
    
    func toggleFavorite(filmID: String) {
        if favoriteIDs.contains(filmID) {
            favoriteIDs.remove(filmID)
        } else {
            favoriteIDs.insert(filmID)
        }
        save()
    }
    
    func isFavorite(filmID: String) -> Bool {
        favoriteIDs.contains(filmID)
    }
}
