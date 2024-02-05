//
//  MovieManager.swift
//  Cinetopia
//
//  Created by Thiago Alex on 04/02/24.
//

import Foundation

class MovieManager {
    
    static let shared = MovieManager()
    var favoritesMovies:[Movie] = []
    
    private init() { }
    
    func addFavorite(movie: Movie) {
        favoritesMovies.append(movie)
    }
    
    func removeFavorite(id: Int) {
        if let index = favoritesMovies.firstIndex(where: { favoriteMovie in
            favoriteMovie.id == id
        }) {
            favoritesMovies.remove(at: index)
        }
    }
}
