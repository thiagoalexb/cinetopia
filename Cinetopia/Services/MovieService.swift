//
//  MovieService.swift
//  Cinetopia
//
//  Created by Thiago Alex on 03/02/24.
//

import Foundation

enum MovieServiceError: Error {
    case invalidURL
    case invalidReponse
    case decodingError
}

struct MovieService {
    
    func getMovies() async throws -> [Movie] {
        
        let urlMovies = "https://my-json-server.typicode.com/alura-cursos/movie-api/movies"
        guard let url = URL(string: urlMovies) else {
            throw MovieServiceError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MovieServiceError.invalidReponse
        }
        
        do {
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            return movies
        }catch (_) {
            throw MovieServiceError.decodingError
        }
    }
}
