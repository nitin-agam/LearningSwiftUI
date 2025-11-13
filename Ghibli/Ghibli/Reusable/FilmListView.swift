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
    
    var isFavorite: Bool {
        favoritesViewModel.isFavorite(filmId: film.id)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            FilmImageView(urlPath: film.imageURL)
                .frame(width: 100, height: 150)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(film.title)
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Button {
                        favoritesViewModel.toggleFavorite(forId: film.id)
                    } label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundStyle(isFavorite ? Color.pink : Color.gray)
                            .font(.system(size: 22))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.bottom, 8)
                
                Text("Director: \(film.director)")
                    .font(.system(size: 16))
                    .padding(.bottom, 1)
                
                Text("Released: \(film.releaseYear)")
                    .font(.system(size: 16))
            }
            .padding(.top)
        }
    }
}

#Preview {
    @State @Previewable var viewModel = FavoritesViewModel(service: MockFavoriteStorage())
    NavigationStack {
        FilmListView(films: Film.examples, favoritesViewModel: viewModel)
    }
}
