//
//  MoviesData.swift
//  19_Networking-2_Martin_Gandeliani
//
//  Created by Martin on 30.11.25.
//
struct SearchResponse: Decodable {
    let search: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct Movie: Decodable {
    let imdbId: String
    let title: String
    let year: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case imdbId = "imdbID"
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
    }
}

