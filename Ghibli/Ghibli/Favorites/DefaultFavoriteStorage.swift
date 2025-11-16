//
//  DefaultFavoriteStorage.swift
//  Ghibli
//
//  Created by Nitin Kumar on 12/11/25.
//

import Foundation

struct DefaultFavoriteStorage: FavoriteStorage {
    
    private let favoriteItemsKey = "ghibli.app.favoriteItems"
    
    func load() -> Set<String> {
        if let favoriteIDs = UserDefaults.standard.stringArray(forKey: favoriteItemsKey) {
            return Set(favoriteIDs)
        }
        return []
    }
    
    func save(favoriteIDs: Set<String>) {
        UserDefaults.standard.set(Array(favoriteIDs), forKey: favoriteItemsKey)
    }
}
