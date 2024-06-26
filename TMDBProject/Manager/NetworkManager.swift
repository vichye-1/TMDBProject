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
    
    typealias recommendHandler = (([RecommendResult]) -> Void)
    
    func fetchSimilar(api: TMDBAPI, completionHandler: @escaping recommendHandler) {
        print(#function)
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.header).validate(statusCode: 200..<500) .responseDecodable(of: Recommendations.self) { response in
            switch response.result {
            case .success(let value):
                print("similarsuccess")
                completionHandler(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchRecommend(movieId: Int, completionHandler: @escaping ([RecommendResult]) -> Void) {
        print(#function)
        let url = APIUrl.tmdbRecommend(id: movieId).urlString
        let parameter: Parameters = [
            Constant.ParameterKey.language: Constant.ParameterValue.korean
        ]
        let header: HTTPHeaders = [
            Constant.HeaderKey.accept: Constant.headerValue.acceptValue,
            Constant.HeaderKey.authorization: APIKey.tmdbAccessToken
        ]
        AF.request(url, method: .get, parameters: parameter, headers: header).responseDecodable(of: Recommendations.self) { response in
            switch response.result {
            case .success(let value):
                print("recommend success")
                completionHandler(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPoster(movieId: Int, completionHandler: @escaping ([PosterResult]) -> Void) {
        print(#function)
        let url = APIUrl.tmdbPoster(id: movieId).urlString
        let header: HTTPHeaders = [
            Constant.HeaderKey.accept: Constant.headerValue.acceptValue,
            Constant.HeaderKey.authorization: APIKey.tmdbAccessToken
        ]
        AF.request(url, method: .get, headers: header).responseDecodable(of: Poster.self) { response in
            switch response.result {
            case .success(let value):
                print("poster success")
                completionHandler(value.posters)
            case .failure(let error):
                print(error)
            }
        }
    }
}
