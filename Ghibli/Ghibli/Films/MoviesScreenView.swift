//
//  MoviesScreenView.swift
//  Ghibli
//
//  Created by Nitin Kumar on 12/11/25.
//

import SwiftUI

struct MoviesScreenView: View {
    
    var filmViewModel: FilmListViewModel
    var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                switch filmViewModel.state {
                    case .idle:
                        Text("No films yet...")
                        
                    case .loading:
                        ProgressView {
                            Text("Loading...")
                        }
                        
                    case .loaded(let films):
                        FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                        
                    case .error(let error):
                        Text(error.localizedUppercase)
                            .foregroundStyle(.red)
                }
            }
            .navigationTitle("Ghibli Movies")
        }
    }
}

#Preview {
    MoviesScreenView(filmViewModel: FilmListViewModel(service: MockGhibliService()), favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage()))
}
