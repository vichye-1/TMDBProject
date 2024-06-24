//
//  Recommendations.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/24/24.
//

import Foundation

struct Recommendations: Decodable {
    let page: Int
    let results: [RecommendResult]
    let total_pages: Int
    let total_results: Int
}

struct RecommendResult: Decodable {
    let poster_path: String?
}
