//
//  GhibliService.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/22/25.
//

import Foundation

// Protocols in swift are like interfaces in Java, can be inherited by classes, structs, enums
// We specify this protocol as sendable.. however, the structs that inherit these do not need to be specified as Sendable as they are immutable and are by default sendable
protocol GhibliService: Sendable {
    func fetchFilms() async throws -> [Film]
    func fetchPerson(from URLString: String) async throws -> Person
}
