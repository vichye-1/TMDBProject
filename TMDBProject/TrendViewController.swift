//
//  ViewController.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/10/24.
//

import UIKit
import Alamofire
import SnapKit

final class TrendViewController: UIViewController {
    
    let movieTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        callRequestMovie()
        callRequestCredit()
        configureTableView()
    }
    
    private func configureHierarchy() {
        view.addSubview(movieTableView)
    }
    
    private func configureLayout() {
        movieTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
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
    
    private func configureTableView() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        let identifier = TrendTableViewCell.identifier
        movieTableView.register(TrendTableViewCell.self, forCellReuseIdentifier: identifier)
        
        movieTableView.rowHeight = 450
    }
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = TrendTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TrendTableViewCell
        return cell
    }
    
    
}
