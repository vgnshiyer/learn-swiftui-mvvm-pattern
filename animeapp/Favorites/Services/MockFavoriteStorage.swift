//
//  MockFavoriteStorage.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
//

import Foundation

struct MockFavoriteStorage: FavoriteStorage {
    func load() -> Set<String> {
        ["2baf70d1-42bb-4437-b551-e5fed5a87abe"]
    }
    
    func save(favoriteIDs: Set<String>) {
        
    }
}
