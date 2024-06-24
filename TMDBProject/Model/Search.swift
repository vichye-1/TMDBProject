//
//  Search.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/11/24.
//

import Foundation

struct Search: Decodable {
    var results: [searchResults]
    var page: Int
    let total_pages: Int
    let total_results: Int
}

struct searchResults: Decodable {
    let original_title: String?
    let poster_path: String?
    let title: String
    let id: Int
}
