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
    
    let recommendTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureTableView()
        callRequestSimilar(movieId: 1022789)
        callRequestRecommend(movieId: 1022789)
        callRequestPoster(movieId: 1022789)
    }
    
    private func configureHierarchy() {
        view.addSubview(movieNameLabel)
        view.addSubview(recommendTableView)
    }
    
    private func configureLayout() {
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(34)
        }
        recommendTableView.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureTableView() {
        recommendTableView.delegate = self
        recommendTableView.dataSource = self
        let identifier = RecommendTableViewCell.identifier
        recommendTableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: identifier)
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
                print("similarsuccess")
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
                print("recommend success")
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
                print("poster success")
            case .failure(let error):
                self.errorAlert(title: "Error!", message: "네트워크 통신이 원활하지 않습니다", ok: "확인")
                print(error)
            }
        }
    }
}

extension RecommendViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = SectionType.allCases[section]
        return sectionType.title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0, 1:
            return 150
        case 2:
            return 200
        default:
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = RecommendTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RecommendTableViewCell
        return cell
    }
}
