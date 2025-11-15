//
//  SearchFilmsViewModel.swift
//  Ghibli
//
//  Created by Nitin Kumar on 15/11/25.
//

import Foundation
import Observation

@Observable
class SearchFilmsViewModel {
    
    var state: LoadingState<[Film]> = .idle
    private let service: GhibliService
    
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }
    
    func fetch(for searchText: String) async {
        
        guard searchText.isEmpty == false else {
            return
        }
        
        self.state = .loading
        
        do {
            let films = try await service.searchFilms(forText: searchText)
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
}
