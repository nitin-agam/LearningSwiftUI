//
//  FilmListView.swift
//  Ghibli
//
//  Created by Nitin Kumar on 11/11/25.
//

import SwiftUI

struct FilmListView: View {
    
    var films: [Film]
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        List(films) { film in
            NavigationLink(value: film) {
                FilmRowItem(film: film, favoritesViewModel: favoritesViewModel)
            }
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailsView(film: film)
        }
    }
}

private struct FilmRowItem: View {
    
    let film: Film
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        HStack {
            FilmImageView(urlPath: film.imageURL)
                .frame(width: 100, height: 150)
            Text(film.title)
            Button {
                favoritesViewModel.toggleFavorite(forId: film.id)
            } label: {
                Image(systemName: favoritesViewModel.isFavorite(filmId: film.id) ? "heart.fill" : "heart")
            }
            .buttonStyle(.plain)
        }
    }
}

//#Preview {
//    @State @Previewable var viewModel = FilmListViewModel(service: MockGhibliService())
//    FilmListView(viewModel: viewModel)
//}
