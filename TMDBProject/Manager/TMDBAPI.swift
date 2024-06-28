//
//  TMDBAPI.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/26/24.
//

import Foundation
import Alamofire

enum TMDBAPI {
    case trendMovie
    case similar(id: Int)
    case recommend(id: Int)
    case poster(id: Int)
    
    var baseURL: String {
        return APIUrl.base.urlString
    }
    var endpoint: URL {
        switch self {
        case .trendMovie:
            return URL(string: baseURL + "trending/movie/week")!
        case .similar(let id):
            return URL(string: baseURL + APIUrl.tmdbSimilar(id: id).urlString)!
        case .recommend(let id):
            return URL(string: baseURL + APIUrl.tmdbRecommend(id: id).urlString)!
        case .poster(let id):
            return URL(string: baseURL + APIUrl.tmdbPoster(id: id).urlString)!
        }
    }
    var parameter: Parameters {
        switch self {
        case .trendMovie, .similar, .recommend:
            return [Constant.ParameterKey.language: Constant.ParameterValue.korean]
        case .poster:
            return ["": ""]
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
