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
    var movieTitle: String? {
        didSet {
            movieNameLabel.text = movieTitle
        }
    }
    var movieId: Int?
    var page = 1
    var recommendPoster : [[RecommendResult]] = [
    [RecommendResult(poster_path: "")],
    [RecommendResult(poster_path: "")]
    ]
    var relatePoster: [PosterResult] = [PosterResult(file_path: "")]
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "극한직업"
        label.textAlignment = .left
        label.font = Constant.Font.bold20
        label.textColor = .black
        return label
    }()
    
    lazy var recommendTableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        let identifier = RecommendTableViewCell.identifier
        tableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        NetworkManager.shared.fetchSimilar(movieId: 1022789) { _ in
            print("SimilarSuccess=====")
        }
        NetworkManager.shared.fetchRecommend(movieId: 1022789) { _ in
            print("recommendSuccess=====")
        }
        NetworkManager.shared.fetchPoster(movieId: 1022789) { _ in
            print("posterSuccess======")
        }
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
