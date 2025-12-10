//
//  FavoritesManager.swift
//  22_ Tabbarcontroller_Martin_Gandeliani
//
//  Created by Martin on 10.12.25.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    private init() {}
    
    private(set) var favoriteMovies: [Movie] = []
    
    func addMovieToFavorite(movie: Movie) {
        if favoriteMovies.isEmpty || !favoriteMovies.contains(where: { $0.imdbId == movie.imdbId } ) {
            favoriteMovies.append(movie)
        }
    }
    
    func removeMovieFromFavorites(movie: Movie) {
        favoriteMovies.removeAll(where: { $0.imdbId == movie.imdbId } )
    }
}
