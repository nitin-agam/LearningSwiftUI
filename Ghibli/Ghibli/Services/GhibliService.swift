//
//  GhibliService.swift
//  Ghibli
//
//  Created by Nitin Kumar on 11/11/25.
//

import Foundation

protocol GhibliService: Sendable {
    func fetchFilms() async throws -> [Film]
    func fetchPerson(from urlString: String) async throws -> Person
    func searchFilms(forText searchText: String) async throws -> [Film]
}
