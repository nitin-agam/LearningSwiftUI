//
//  FavoriteButton.swift
//  Ghibli
//
//  Created by Nitin Kumar on 13/11/25.
//

import SwiftUI

struct FavoriteButton: View {
    
    let filmID: String
    let favoritesViewModel: FavoritesViewModel
    
    var isFavorite: Bool {
        favoritesViewModel.isFavorite(filmId: filmID)
    }
    
    var body: some View {
        Button {
            favoritesViewModel.toggleFavorite(forId: filmID)
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? Color.pink : Color.gray)
                .font(.system(size: 22))
        }
    }
}

#Preview {
    FavoriteButton(filmID: Film.example.id, favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage()))
}
