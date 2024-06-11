//
//  Search.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/11/24.
//

import Foundation

struct Search: Decodable {
    var page: Int
    let results: [searchResults]
}

struct searchResults: Decodable {
    let poster_path: String?
}
