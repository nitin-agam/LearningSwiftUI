//
//  FilmDetailsViewModel.swift
//  Ghibli
//
//  Created by Nitin Kumar on 12/11/25.
//

import Foundation
import Observation

@Observable
class FilmDetailsViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Person])
        case error(String)
    }
    
    var state: State = .idle
    private var service: GhibliService
    
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }
    
    func fetch(for film: Film) async {
        
        guard state != .loading else { return }
        self.state = .loading
        
        var fetchedPeople: [Person] = []
        
        do {
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personInfoUrl in film.people {
                    group.addTask {
                        try await self.service.fetchPerson(from: personInfoUrl)
                    }
                }
                
                for try await person in group {
                    fetchedPeople.append(person)
                }
            }
            self.state = .loaded(fetchedPeople)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
}

import Playgrounds

#Playground {
    
    let service = MockGhibliService()
    let viewModel = FilmDetailsViewModel(service: service)
    let film = service.fetchFilm()
    print("film title: \(film.title)")
    await viewModel.fetch(for: film)
    
    switch viewModel.state {
        case .idle: print("idle...")
        case .loading: print("loading...")
        case .error(let string): print("error: \(string)")
        case .loaded(let array):
            print("array count: \(array.count)")
            for person in array {
                print("name: ", person.name)
            }
    }
}
