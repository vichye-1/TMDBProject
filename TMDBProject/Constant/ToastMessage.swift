//
//  ToastMessage.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/28/24.
//

import Foundation

enum ToastMessage {
    case similarMovie
    case recommendedMovie
    case poster
    
    var message: String {
        switch self {
        case .similarMovie:
            return "비슷한 영화의 결과를 불러올 수 없습니다. 잠시후 다시 실행해주세요."
        case .recommendedMovie:
            return "추천 영화의 결과를 불러올 수 없습니다. 잠시후 다시 실행해주세요."
        case .poster:
            return "영화 포스터의 결과를 불러올 수 없습니다. 잠시후 다시 실행해주세요"
        }
    }
}
