//
//  MockGhibliService.swift
//  Ghibli
//
//  Created by Nitin Kumar on 11/11/25.
//

import Foundation

struct MockGhibliService: GhibliService {
    
    struct SampleData: Decodable {
        let films: [Film]
        let people: [Person]
    }
    
    private func loadSampleData() throws -> SampleData {
        
        guard let localUrl = Bundle.main.url(forResource: "SampleData", withExtension: "json") else {
            throw APIError.invalidURL
        }
        
        do {
            let data = try Data(contentsOf: localUrl)
            return try JSONDecoder().decode(SampleData.self, from: data)
        } catch let error as DecodingError {
            print(error)
            throw APIError.decodingError(error)
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    // MARK: - Protocol Conformation
    func fetchFilms() async throws -> [Film] {
        let sampleData = try loadSampleData()
        return sampleData.films
    }
    
    func fetchPerson(from urlString: String) async throws -> Person {
        let sampleData = try loadSampleData()
        return sampleData.people.first!
    }
    
    // MARK: - Testing
    func fetchFilm() -> Film {
        let sampleData = try! loadSampleData()
        return sampleData.films.first!
    }
}
