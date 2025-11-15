//
//  ContentView.swift
//  Ghibli
//
//  Created by Nitin Kumar on 12/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var filmViewModel = FilmListViewModel()
    @State private var favoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                MoviesScreenView(filmViewModel: filmViewModel, favoritesViewModel: favoritesViewModel)
            }
            
            Tab("Favorites", systemImage: "heart") {
                FavoritesScreenView(filmsViewModel: filmViewModel, favoritesViewModel: favoritesViewModel)
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsScreenView()
            }
            
            Tab(role: .search) {
                SearchScreenView(favoritesViewModel: favoritesViewModel)
            }
        }
        .task {
            favoritesViewModel.load()
            await filmViewModel.fetch()
        }
    }
}

#Preview {
    ContentView()
}
