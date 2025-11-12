//
//  FavoriteStorage.swift
//  Ghibli
//
//  Created by Nitin Kumar on 12/11/25.
//

import Foundation

protocol FavoriteStorage {
    func load() -> Set<String>
    func save(favoriteIDs: Set<String>)
}
