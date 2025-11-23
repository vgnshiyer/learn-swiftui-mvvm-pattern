//
//  MockGhibliService.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
//

import Foundation

struct MockGhibliService: GhibliService {
    
    private struct SampleData: Decodable {
        let films: [Film]
        let people: [Person]
    }
    
    private func loadSampleData() throws -> SampleData {
        guard let url = Bundle.main.url(forResource: "SampleData", withExtension: "json") else {
            throw APIError.invalidURL
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(SampleData.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    func fetchFilms() async throws -> [Film] {
        return try loadSampleData().films
    }
    
    func searchFilms(for query: String) async throws -> [Film] {
        let allFilms = try await fetchFilms()
        return allFilms.filter { film in
            film.title.localizedStandardContains(query)
        }
    }

    // MARK: preview/testing only
    func fetchFilm() -> Film {
        let data = try! loadSampleData()
        return data.self.films.first!
    }
    
    func fetchPerson(from URLString: String) async throws -> Person {
        return try loadSampleData().people.first!
    }
    
}
