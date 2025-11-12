//
//  FilmListView.swift
//  Ghibli
//
//  Created by Nitin Kumar on 11/11/25.
//

import SwiftUI

struct FilmListView: View {
    
    var viewModel: FilmListViewModel
    
    var body: some View {
        NavigationStack {
            switch viewModel.state {
                case .idle:
                    Text("No films yet...")
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                case .loaded(let films):
                    List(films) { film in
                        NavigationLink(value: film) {
                            Text(film.title)
                        }
                    }
                    .navigationDestination(for: Film.self) { film in
                        FilmDetailsView(film: film)
                    }
                case .error(let error):
                    Text(error.localizedUppercase)
                        .foregroundStyle(.red)
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
}

#Preview {
    @State @Previewable var viewModel = FilmListViewModel(service: MockGhibliService())
    FilmListView(viewModel: viewModel)
}
