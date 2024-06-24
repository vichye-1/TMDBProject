//
//  RecommendViewController.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/24/24.
//

import UIKit
import Alamofire
import SnapKit

class RecommendViewController: UIViewController {
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        callRequestSimilar(movieId: 940721)
        callRequestRecommend(movieId: 940721)
        callRequestPoster(movieId: 1022789)
    }
    
    private func configureHierarchy() {
        
    }
    
    private func configureLayout() {
        
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func callRequestSimilar(movieId: Int) {
        print(#function)
        let url = APIUrl.tmdbSimilar(id: movieId).urlString
        let parameter: Parameters = [
            Constant.ParameterKey.language: Constant.ParameterValue.korean,
            "page": "\(page)"
        ]
        let header: HTTPHeaders = [
            Constant.HeaderKey.accept: Constant.headerValue.acceptValue,
            Constant.HeaderKey.authorization: APIKey.tmdbAccessToken
        ]
        
        AF.request(url, method: .get, parameters: parameter, headers: header).responseDecodable(of: Similar.self) { response in
            switch response.result {
            case .success(let value):
                print("******\(value)*******")
            case .failure(let error):
                self.errorAlert(title: "Error!", message: "네트워크 통신이 원활하지 않습니다", ok: "확인")
                print(error)
            }
        }
    }
    
    private func callRequestRecommend(movieId: Int) {
        print(#function)
        let url = APIUrl.tmdbRecommend(id: movieId).urlString
        let parameter: Parameters = [
            Constant.ParameterKey.language: Constant.ParameterValue.korean,
            "page": "\(page)"
        ]
        let header: HTTPHeaders = [
            Constant.HeaderKey.accept: Constant.headerValue.acceptValue,
            Constant.HeaderKey.authorization: APIKey.tmdbAccessToken
        ]
        
        AF.request(url, method: .get, parameters: parameter, headers: header).responseDecodable(of: Recommendations.self) { response in
            switch response.result {
            case .success(let value):
                print("======\(value)======")
            case .failure(let error):
                self.errorAlert(title: "Error!", message: "네트워크 통신이 원활하지 않습니다", ok: "확인")
                print(error)
            }
        }
    }
    
    private func callRequestPoster(movieId: Int) {
        print(#function)
        let url = APIUrl.tmdbPoster(id: movieId).urlString
        let header: HTTPHeaders = [
            Constant.HeaderKey.accept: Constant.headerValue.acceptValue,
            Constant.HeaderKey.authorization: APIKey.tmdbAccessToken
        ]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: Poster.self) { response in
            switch response.result {
            case .success(let value):
                print("++++++++\(value)++++++++++")
            case .failure(let error):
                self.errorAlert(title: "Error!", message: "네트워크 통신이 원활하지 않습니다", ok: "확인")
                print(error)
            }
        }
    }
}
