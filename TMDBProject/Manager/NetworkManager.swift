//
//  NetworkManager.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/24/24.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    typealias recommendHandler = ([RecommendResult]?, AFError?) -> Void
    typealias posterHandler = ([PosterResult]?, AFError?) -> Void
    
    func fetchRecommend(api: TMDBAPI, completionHandler: @escaping recommendHandler) {
        print(#function)
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.header).validate(statusCode: 200..<500).responseDecodable(of: Recommendations.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.results, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    func fetchPoster(api: TMDBAPI, completionHandler: @escaping posterHandler) {
        print(#function)
        AF.request(api.endpoint, method: api.method, headers: api.header).responseDecodable(of: Poster.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.posters, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
