//
//  Credit.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/10/24.
//

import Foundation

struct Credit: Decodable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Decodable {
    let name: String
    let profile_path: String?
    let character: String
}
