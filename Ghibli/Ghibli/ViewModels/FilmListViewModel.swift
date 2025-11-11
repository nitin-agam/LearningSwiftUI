//
//  FilmListViewModel.swift
//  Ghibli
//
//  Created by Nitin Kumar on 11/11/25.
//

import Foundation
import Observation

enum APIError: LocalizedError {
    
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
            case .invalidURL: return "Invalid URL"
            case .invalidResponse: return "Invalid Response"
            case .decodingError(let error): return "Decoding Error: \(error.localizedDescription)"
            case .networkError(let error): return "Network Error: \(error.localizedDescription)"
        }
    }
}

@Observable
class FilmListViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }
    
    var films: [Film] = []
    var state: State = .idle
    
    func fetch() async {
        guard state == .idle else { return }
        self.state = .loading
        do {
            let films = try await fetchFilms()
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
    
    private func fetchFilms() async throws -> [Film] {
        
        guard let url = URL(string: "https://ghibliapi.vercel.app/films") else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            return try JSONDecoder().decode([Film].self, from: data)
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
}
