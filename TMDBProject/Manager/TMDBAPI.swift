//
//  TMDBAPI.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/26/24.
//

import Foundation
import Alamofire

enum TMDBAPI {
    case similar(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    var endpoint: URL {
        switch self {
        case .similar(let id):
            return URL(string: baseURL + "movie/\(id)/similar")!
        }
    }
    var parameter: Parameters {
        switch self {
        case .similar:
            return [Constant.ParameterKey.language: Constant.ParameterValue.korean]
        }
    }
    var header: HTTPHeaders {
        [
            Constant.HeaderKey.accept: Constant.headerValue.acceptValue,
            Constant.HeaderKey.authorization: APIKey.tmdbAccessToken
        ]
    }
    var method: HTTPMethod {
        return .get
    }
}