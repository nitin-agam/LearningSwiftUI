//
//  FilmDetailsView.swift
//  Ghibli
//
//  Created by Nitin Kumar on 12/11/25.
//

import SwiftUI

struct FilmDetailsView: View {
    
    @State private var viewModel = FilmDetailsViewModel()
    let film: Film
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                FilmImageView(urlPath: film.bannerImageURL)
                    .frame(height: 300)
                    .containerRelativeFrame(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(film.title)
                    
                    Divider()
                    
                    switch viewModel.state {
                        case .idle:
                            Text("No details yet...")
                            
                        case .loading:
                            ProgressView {
                                Text("Loading...")
                            }
                            
                        case .loaded(let people):
                            ForEach(people) { person in
                                Text(person.name)
                            }
                            
                        case .error(let error):
                            Text(error.localizedUppercase)
                                .foregroundStyle(.red)
                    }
                }
                .padding()
            }
        }
        .task(id: film) {
            await self.viewModel.fetch(for: film)
        }
    }
}

#Preview {
    FilmDetailsView(film: Film.example)
}
