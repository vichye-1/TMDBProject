//
//  ViewController.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/10/24.
//

import UIKit
import Alamofire
import SnapKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        callRequestMovie()
        callRequestCredit()
    }
    
    private func configureView() {
        print(#function)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.triangle"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        view.backgroundColor = .white
    }
    
    private func callRequestMovie() {
        print(#function)
        let url = APIUrl.tmdbmovie.urlString
        let parameters: Parameters = [
            "language": "ko-KR"
        ]
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": APIKey.tmdbAccessToken
        ]
        AF.request(url, method: .get, parameters: parameters, headers: header).responseDecodable(of: Movie.self)
        { response in
            switch response.result {
            case .success(let value):
                var idList: [Int] = []
                for i in 0..<value.results.count {
                    idList.append(value.results[i].id)
                }
                print(idList)
            case .failure(let error):
                print("movie: \(error)")
            }
        }
    }
    
    private func callRequestCredit() {
        print(#function)
        let url = APIUrl.tmdbMovieCredit(id: 940721).urlString
        let parameters: Parameters = [
            "language": "ko-KR"
        ]
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": APIKey.tmdbAccessToken
        ]
        
//        AF.request(url).responseString { response in  // request하면 response해야함
//            switch response.result {
//            case .success(let value):
//                print(value)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        
        AF.request(url, method: .get, parameters: parameters, headers: header).responseDecodable(of: Credit.self) { response in
            switch response.result {
            case .success(let value):
                print(value.cast)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    


}

