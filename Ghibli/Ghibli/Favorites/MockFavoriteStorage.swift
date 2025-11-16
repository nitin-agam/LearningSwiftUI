//
//  MockFavoriteStorage.swift
//  Ghibli
//
//  Created by Nitin Kumar on 12/11/25.
//

import Foundation

struct MockFavoriteStorage: FavoriteStorage {
    
    func load() -> Set<String> {
        return ["2baf70d1-42bb-4437-b551-e5fed5a87abe",
                "12cfb892-aac0-4c5b-94af-521852e46d6a"]
    }
    
    func save(favoriteIDs: Set<String>) {
        
    }
}
