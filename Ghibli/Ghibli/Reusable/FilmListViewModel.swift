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
    
    var state: LoadingState<[Film]> = .idle
    private let service: GhibliService
    
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }
    
    func fetch() async {
        guard state.isLoading == false else { return }
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
    
    // MARK: - Preview
    static var previewExample: FilmListViewModel {
        let viewModel = FilmListViewModel(service: MockGhibliService())
        viewModel.state = .loaded([Film.example])
        return viewModel
    }
}
