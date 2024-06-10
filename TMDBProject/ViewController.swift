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
        view.backgroundColor = .gray
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
        AF.request(url, method: .get, parameters: parameters, headers: header).responseString { response in
            switch response.result {
            case .success(let value):
                print(value)
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
        AF.request(url, method: .get, parameters: parameters, headers: header).responseString { response in  // request하면 response해야함
            switch response.result {
            case .success(let value):
                print("Credit Success")
            case .failure(let error):
                print("error: \(error)")
            }
        }
        
    }
    
    


}

