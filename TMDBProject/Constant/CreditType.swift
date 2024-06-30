//
//  CreditType.swift
//  TMDBProject
//
//  Created by 양승혜 on 7/1/24.
//

import Foundation

enum CreditType: Int, CaseIterable {
    case overview
    case cast
    
    var title: String {
        switch self {
        case .overview:
            return "OverView"
        case .cast:
            return "Cast"
        }
    }
}
