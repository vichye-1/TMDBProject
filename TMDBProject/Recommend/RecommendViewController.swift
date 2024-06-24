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
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "극한직업"
        label.textAlignment = .left
        label.font = Constant.Font.bold20
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        callRequestSimilar(movieId: 1022789)
        callRequestRecommend(movieId: 1022789)
        callRequestPoster(movieId: 1022789)
    }
    
    private func configureHierarchy() {
        view.addSubview(movieNameLabel)
    }
    
    private func configureLayout() {
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(34)
        }
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
