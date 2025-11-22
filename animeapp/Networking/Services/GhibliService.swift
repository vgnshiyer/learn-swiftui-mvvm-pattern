//
//  GhibliService.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
//

import Foundation

// Protocols in swift are like interfaces in Java, can be inherited by classes, structs, enums
protocol GhibliService {
    func fetchFilms() async throws -> [Film]
    func fetchPeople(from URLString: String) async throws -> Person
}
