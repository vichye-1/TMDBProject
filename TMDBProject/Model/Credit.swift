//
//  Credit.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/10/24.
//

import Foundation

struct Credit {
    let id: Int
    let cast: [castList]
}

struct castList {
    let name: String
    let profile_path: String
}
