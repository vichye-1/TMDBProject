//
//  Genres.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/12/24.
//

import Foundation

struct Genres: Decodable {
    var genres: [GenreDetail]
}

struct GenreDetail: Decodable {
    let id: Int
    let name: String
}
