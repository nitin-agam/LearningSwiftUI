//
//  Film.swift
//  Ghibli
//
//  Created by Nitin Kumar on 11/11/25.
//

import Foundation

struct Film: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let director: String
    let producer: String
    let releaseYear: String
    let duration: String
    let score: String
    let imageURL: String
    let bannerImageURL: String
    
    let people: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, director, producer, people
        case releaseYear = "release_date"
        case duration = "running_time"
        case score = "rt_score"
        case bannerImageURL = "movie_banner"
        case imageURL = "image"
    }
}

import Playgrounds

#Playground {
    
    let urlString = "https://ghibliapi.vercel.app/films"
    let url = URL(string: urlString)!
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        let films = try JSONDecoder().decode([Film].self, from: data)
        print("film count: \(films.count)")
    } catch {
        print("error")
    }
}
