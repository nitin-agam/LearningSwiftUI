//
//  FilmListViewModel.swift
//  Ghibli
//
//  Created by Nitin Kumar on 11/11/25.
//

import Foundation
import Observation

@Observable
class FilmListViewModel {
    
    var films: [Film] = []
    
    func fetchFilms() async {
        
        let urlString = "https://ghibliapi.vercel.app/films"
        let url = URL(string: urlString)!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let films = try JSONDecoder().decode([Film].self, from: data)
            self.films = films
            print("film count: \(films.count)")
        } catch {
            print("error")
        }
    }
}
