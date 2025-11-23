//
//  SearchFilmsViewModel.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/23/25.
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
    
    func fetch(for query: String) async {
        guard !query.isEmpty else {
            state = .idle
            return
        }
        state = .loading
        
        try? await Task.sleep(for: .milliseconds(500))
        guard !Task.isCancelled else { return }

        do {
            let films = try await service.searchFilms(for: query)
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.localizedDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
}
