//
//  Person.swift
//  Ghibli
//
//  Created by Nitin Kumar on 11/11/25.
//

import Foundation

struct Person: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let gender: String
    let age: String
    let eyeColor: String
    let hairColor: String
    let films: [String]
    let species: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, gender, age, films, species, url
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
    }
}


import Playgrounds

#Playground {
    
    let url = URL(string: "https://ghibliapi.vercel.app/people/2409052a-9029-4e8d-bfaf-70fd82c8e48d")!
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(Person.self, from: data)
        print(result)
    } catch {
        print(error)
    }
}
