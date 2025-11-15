//
//  FavoritesScreenView.swift
//  Ghibli
//
//  Created by Nitin Kumar on 12/11/25.
//

import SwiftUI

struct FavoritesScreenView: View {
    
    var filmsViewModel: FilmListViewModel
    var favoritesViewModel: FavoritesViewModel
    
    var films: [Film] {
        let favorites = favoritesViewModel.favoriteIds
        switch filmsViewModel.state {
            case .loaded(let array):
                return array.filter({ favorites.contains($0.id) })
            default: return []
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView("No Favorites Yet", systemImage: "heart")
                } else {
                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                }
            }
            .navigationTitle("My Favorites")
        }
    }
}

#Preview {
    FavoritesScreenView(filmsViewModel: FilmListViewModel.previewExample, favoritesViewModel: FavoritesViewModel.previewExample)
}
