//
//  MovieViewModel.swift
//  20_ MVVM_Martin_Gandeliani
//
//  Created by Martin on 01.12.25.
//

import Foundation
import UIKit

class MovieViewModel {
    var moviesManager = MoviesManager()
    
    var allMovies: [Movie] = []
    var nextMovie: [Movie] = []
    var movies: [Movie] = []
    var currentIndexOfMovie = 0
    
    var moviesUploaded: (() -> Void)?
    var showAlert: (() -> Void)?
    
    func loadAllMovies() {
        moviesManager.getMoviesData { [weak self] allDownloadedMovies in
            guard let self = self else { return }

            self.allMovies = allDownloadedMovies
            self.moviesUploaded?()
        }
    }
    
    func getNextMovie() {
            if self.currentIndexOfMovie < self.allMovies.count {
                let nextMovie = allMovies[self.currentIndexOfMovie]
                self.nextMovie.append(nextMovie)
                self.currentIndexOfMovie += 1
                self.moviesUploaded?()
            } else {
                self.showAlert?()
            }
        }
}

