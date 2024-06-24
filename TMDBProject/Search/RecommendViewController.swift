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
        callRequestSimilar(moiveId: 940721)
    }
    
    private func configureHierarchy() {
        
    }
    
    private func configureLayout() {
        
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func callRequestSimilar(moiveId: Int) {
        print(#function)
        let url = APIUrl.tmdbSimilar(id: 940721).urlString
        var parameter: Parameters = [
            "language": "ko-KR",
            "page": "\(page)"
        ]
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": APIKey.tmdbAccessToken
        ]
        
        AF.request(url, method: .get, parameters: parameter, headers: header).responseDecodable(of: Similar.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                self.errorAlert(title: "Error!", message: "네트워크 통신이 원활하지 않습니다", ok: "확인")
                print(error)
            }
        }
    }
}
