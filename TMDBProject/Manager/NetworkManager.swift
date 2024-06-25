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
    
    func fetchSimilar(movieId: Int, completionHandler: @escaping ([RecommendResult]) -> Void) {
        print(#function)
        let url = APIUrl.tmdbSimilar(id: movieId).urlString
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
}
