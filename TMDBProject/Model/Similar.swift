//
//  Similar.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/24/24.
//

import Foundation

struct Similar: Decodable {
    let page: Int
    let results: [SimilarResult]
    let total_pages: Int
    let total_results: Int
}

struct SimilarResult: Decodable {
    let poster_path: String?
}
