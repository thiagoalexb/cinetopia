//
//  Movie.swift
//  Cinetopia
//
//  Created by Thiago Alex on 02/02/24.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let image: String
    let synopsis: String
    let rate: Double
    let releaseDate: String
}

