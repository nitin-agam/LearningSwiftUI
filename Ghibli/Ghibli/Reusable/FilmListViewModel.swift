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
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }
    
    var films: [Film] = []
    var state: State = .idle
    private let service: GhibliService
    
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }
    
    func fetch() async {
        guard state == .idle else { return }
        self.state = .loading
        do {
            let films = try await service.fetchFilms()
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
}
