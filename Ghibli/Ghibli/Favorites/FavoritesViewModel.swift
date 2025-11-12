//
//  FavoritesViewModel.swift
//  Ghibli
//
//  Created by Nitin Kumar on 12/11/25.
//

import Foundation
import Observation

@Observable
class FavoritesViewModel {
    
    private(set) var favoriteIds: Set<String> = []
    private let service: FavoriteStorage
    
    init(service: FavoriteStorage = DefaultFavoriteStorage()) {
        self.service = service
    }
    
    func load() {
        self.favoriteIds = service.load()
    }
    
    private func save() {
        service.save(favoriteIDs: favoriteIds)
    }
    
    func toggleFavorite(forId filmId: String) {
        if favoriteIds.contains(filmId) {
            favoriteIds.remove(filmId)
        } else {
            favoriteIds.insert(filmId)
        }
        
        save()
    }
    
    func isFavorite(filmId: String) -> Bool {
        favoriteIds.contains(filmId)
    }
}
