//
//  SearchScreenView.swift
//  Ghibli
//
//  Created by Nitin Kumar on 12/11/25.
//

import SwiftUI

struct SearchScreenView: View {
    
    @State private var searchText = ""
    @State private var searchViewModel: SearchFilmsViewModel
    let favoritesViewModel: FavoritesViewModel
    
    init(service: GhibliService = DefaultGhibliService(), favoritesViewModel: FavoritesViewModel) {
        self.searchViewModel = SearchFilmsViewModel(service: service)
        self.favoritesViewModel = favoritesViewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                switch searchViewModel.state {
                    case .idle:
                        Text("Show search here...")
                        
                    case .loading: ProgressView()
                        
                    case .error(let message):
                        Text(message)
                        
                    case .loaded(let films):
                        FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                        
                }
            }
            .searchable(text: $searchText)
            .task(id: searchText) {
                await searchViewModel.fetch(for: searchText)
            }
        }
    }
}

#Preview {
    SearchScreenView(favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage()))
}
