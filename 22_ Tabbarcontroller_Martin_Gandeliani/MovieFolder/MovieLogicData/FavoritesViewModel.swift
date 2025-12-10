//
//  MovieViewModel.swift
//  20_ MVVM_Martin_Gandeliani
//
//  Created by Martin on 01.12.25.
//

import Foundation
import UIKit

class FavoritesViewModel {
    
    var favoriteMovies: [Movie] {
        FavoritesManager.shared.favoriteMovies
    }
    
    func addMovieToFavorites(movie: Movie) {
        FavoritesManager.shared.addMovieToFavorite(movie: movie)
        refreshTab()
    }
    
    func removeMovieFromFavorites(movie: Movie) {
        FavoritesManager.shared.removeMovieFromFavorites(movie: movie)
        refreshTab()
    }
    
    var movieAdded: (() -> Void)?
    
    func refreshTab() {
        movieAdded?()
    }
}
