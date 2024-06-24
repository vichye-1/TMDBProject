//
//  SectionType.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/25/24.
//

import Foundation

enum SectionType: Int, CaseIterable {
    case similarMovie
    case recommendedMovie
    case poster
    
    var title: String {
        switch self {
        case .similarMovie:
            return "비슷한 영화"
        case .recommendedMovie:
            return "추천 영화"
        case .poster:
            return "포스터"
        }
    }
}
