//
//  GhibliTests.swift
//  GhibliTests
//
//  Created by Nitin Kumar on 11/11/25.
//

import Foundation
import Testing
@testable import Ghibli

struct GhibliTests {

    struct MockGhibliService: GhibliService {
        
        let mockFilms: [Film]
        let shouldThrowError: Bool
        let fetchDelay: Duration
        
        init(mockFilms: [Film], shouldThrowError: Bool, fetchDelay: Duration = .zero) {
            self.mockFilms = mockFilms
            self.shouldThrowError = shouldThrowError
            self.fetchDelay = fetchDelay
        }
        
        // MARK: - Protocol Conformation
        func fetchFilms() async throws -> [Film] {
            if shouldThrowError {
                throw APIError.networkError(NSError(domain: "", code: -1))
            }
            
            if fetchDelay > .zero {
                try? await Task.sleep(for: fetchDelay)
            }
            
            return mockFilms
        }
        
        func fetchPerson(from urlString: String) async throws -> Person {
            .init(id: "", name: "", gender: "", age: "", eyeColor: "", hairColor: "", films: [], species: "", url: "")
        }
        
        func searchFilms(forText searchText: String) async throws -> [Film] {
            
            if shouldThrowError {
                throw APIError.networkError(NSError(domain: "", code: -1))
            }
            
            if fetchDelay > .zero {
                try? await Task.sleep(for: fetchDelay)
            }
            
            guard searchText.isEmpty else {
                return mockFilms
            }
            
            return mockFilms.filter { film in
                film.title.localizedStandardContains(searchText)
            }
        }
    }
    
    // MARK: - Test Data
    let mockFilms = [
        Film(
            id: "1",
            title: "My Neighbor Totoro",
            description: "Two sisters discover Totoro",
            director: "Hayao Miyazaki",
            producer: "Isao Takahata",
            releaseYear: "1988",
            duration: "",
            score: "93",
            imageURL: "",
            bannerImageURL: "",
            people: []
        ),
        Film(
            id: "2",
            title: "Spirited Away",
            description: "A girl enters a spirit world",
            director: "Hayao Miyazaki",
            producer: "Toshio Suzuki",
            releaseYear: "2001",
            duration: "",
            score: "97",
            imageURL: "",
            bannerImageURL: "",
            people: []
        ),
        Film(
            id: "3",
            title: "Princess Mononoke",
            description: "A prince fights to save the forest",
            director: "Hayao Miyazaki",
            producer: "Toshio Suzuki",
            releaseYear: "1997",
            duration: "",
            score: "92",
            imageURL: "",
            bannerImageURL: "",
            people: []
        )
    ]
    
    @MainActor
    @Test func testInitialState() async throws {
        
        let service = MockGhibliService(mockFilms: mockFilms, shouldThrowError: false)
        let searchFilmsViewModel = SearchFilmsViewModel(service: service)
        
        #expect(searchFilmsViewModel.state.data == nil)
        
        if case .idle = searchFilmsViewModel.state {
            
        } else {
            Issue.record("State should be .idle at the start.")
        }
    }
    
    @MainActor
    @Test func testSearchWithQuery() async throws {
        
        let service = MockGhibliService(mockFilms: mockFilms, shouldThrowError: false)
        let searchFilmsViewModel = SearchFilmsViewModel(service: service)
        
        await searchFilmsViewModel.fetch(for: "Sky")
        
      //  #expect(searchFilmsViewModel.state.data?.count == 1)
      //  #expect(searchFilmsViewModel.state.data?.first?.title == "Castle in the Sky")
    }
    
    @MainActor
    @Test func testSearchWithError() async throws {
        let service = MockGhibliService(mockFilms: mockFilms, shouldThrowError: true)
        let searchFilmsViewModel = SearchFilmsViewModel(service: service)
        await searchFilmsViewModel.fetch(for: "Sky")
        #expect(searchFilmsViewModel.state.error != nil)
    }
    
    @MainActor
    @Test func testCancellationAfterRequest() async {
        
        let service = MockGhibliService(mockFilms: mockFilms,
                                        shouldThrowError: false,
                                        fetchDelay: .milliseconds(100))
        let viewModel = SearchFilmsViewModel(service: service)
        
        let task = Task {
            print("started task")
            await viewModel.fetch(for: "tot")
        }
        
        try? await Task.sleep(for: .milliseconds(50))
//        task.cancel()
        
        await task.value
        
        print(viewModel.state)
    }
}
