//
//  DefaultGhibliService.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
//

import Foundation

// services purely contain functions without any mutable state - thats why we use structs as they are very lightweight and are immutable
struct DefaultGhibliService: GhibliService {
    func fetch<T: Decodable>(from URLString: String, _ type: T.Type) async throws -> T {
        guard let url = URL(string: URLString) else {
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
    
    func fetchFilms() async throws -> [Film] {
        let url = "https://ghibliapi.vercel.app/films"
        return try await fetch(from: url, [Film].self)
    }
    
    func fetchPerson(from URLString: String) async throws -> Person {
        return try await fetch(from: URLString, Person.self)
    }
    
    func searchFilms(for query: String) async throws -> [Film] {
        let allFilms = try await fetchFilms()
        return allFilms.filter { film in
            film.title.localizedStandardContains(query)
        }
    }
}
