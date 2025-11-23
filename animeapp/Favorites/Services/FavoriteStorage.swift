//
//  FavoriteStorage.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
//

protocol FavoriteStorage {
    func load() -> Set<String>
    func save(favoriteIDs: Set<String>)
}
