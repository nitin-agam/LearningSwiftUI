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
        return []
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
    FavoritesScreenView(filmsViewModel: FilmListViewModel(service: MockGhibliService()), favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage()))
}
