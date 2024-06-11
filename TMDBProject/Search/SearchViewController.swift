//
//  SearchViewController.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/11/24.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

class SearchViewController: UIViewController {
    
    var keyword: String = "factory"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequestSearch()
        
    }
    
    func callRequestSearch() {
        print(#function)
        let url = APIUrl.tmdbSearch.urlString
        let parameters: Parameters = [
            "query": "\(keyword)",
            "language": "ko-KR"
        ]
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": APIKey.tmdbAccessToken
        ]
                
        AF.request(url, method: .get, parameters: parameters, headers: header).responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    


}
