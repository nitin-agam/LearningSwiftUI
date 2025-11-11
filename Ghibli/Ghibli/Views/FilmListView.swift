//
//  FilmListView.swift
//  Ghibli
//
//  Created by Nitin Kumar on 11/11/25.
//

import SwiftUI

struct FilmListView: View {
    
    @State private var viewModel = FilmListViewModel()
    
    var body: some View {
        List(viewModel.films) { film in
            Text(film.title)
        }
        .task {
            await viewModel.fetchFilms()
        }
    }
}

#Preview {
    FilmListView()
}
