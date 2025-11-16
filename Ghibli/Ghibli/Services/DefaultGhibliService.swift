//
//  DefaultGhibliService.swift
//  Ghibli
//
//  Created by Nitin Kumar on 11/11/25.
//

import Foundation

struct DefaultGhibliService: GhibliService {
    
    private func fetch<T: Decodable>(from urlString: String, type: T.Type) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            return try JSONDecoder().decode(type, from: data)
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
    
    // MARK: - Protocol Conformation
    func fetchFilms() async throws -> [Film] {
        let urlString = "https://ghibliapi.vercel.app/films"
        return try await fetch(from: urlString, type: [Film].self)
    }
    
    func fetchPerson(from urlString: String) async throws -> Person {
        return try await fetch(from: urlString, type: Person.self)
    }
    
    func searchFilms(forText searchText: String) async throws -> [Film] {
        let allFilms = try await fetchFilms()
        return allFilms.filter { film in
            film.title.localizedStandardContains(searchText)
        }
    }
}
