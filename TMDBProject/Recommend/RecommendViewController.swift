//
//  RecommendViewController.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/24/24.
//

import UIKit
import Alamofire
import Kingfisher
import SkeletonView
import SnapKit
import Toast

class RecommendViewController: UIViewController {
    var movieTitle: String? {
        didSet {
            movieNameLabel.text = movieTitle
        }
    }
    var movieId: Int = 0
    var page = 1
    var posterList : [[RecommendResult]] = [
    [RecommendResult(poster_path: "")],
    [RecommendResult(poster_path: "")]
    ]
    var relatePosterList: [PosterResult] = [PosterResult(file_path: "")]
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
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
        tableView.isSkeletonable = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        fetchMovieData(movieId: movieId)
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
        recommendTableView.separatorStyle = .none
    }
    
    private func fetchMovieData(movieId: Int) {
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.fetchRecommend(api: .similar(id: movieId)) { success, error in
                if let success = success {
                    self.posterList[0] = success
                } else {
                    self.showToastMessage(message: ToastMessage.similarMovie.message)
                }
                self.recommendTableView.reloadData()
                group.leave()
            }
        }
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.fetchRecommend(api: .recommend(id: movieId)) { success, error in
                if let success = success {
                    self.posterList[1] = success
                } else {
                    self.showToastMessage(message: ToastMessage.recommendedMovie.message)
                }
                self.recommendTableView.reloadData()
                group.leave()
            }
        }
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.fetchPoster(api: .poster(id: movieId)) { success, error in
                if let success = success {
                    self.relatePosterList = success
                } else {
                    self.showToastMessage(message: ToastMessage.poster.message)
                }
                self.recommendTableView.reloadData()
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.recommendTableView.reloadData()
        }
    }
    private func showToastMessage(message: String) {
        self.view.makeToast(message, position: .bottom)
    }
}

extension RecommendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 1:
            return 200
        case 2:
            return 300
        default:
            return 200
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SectionType.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCellIdentifier = RecommendTableViewCell.identifier
        let collectionViewCellIdentifier = RecommendCollectionViewCell.identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as? RecommendTableViewCell else {
            return UITableViewCell()
        }
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellIdentifier)
        cell.collectionView.tag = indexPath.row
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = SectionType.similarMovie.title
        case 1:
            cell.titleLabel.text = SectionType.recommendedMovie.title
        case 2:
            cell.titleLabel.text = SectionType.poster.title
        default:
            break
        }
        cell.collectionView.reloadData()
        return cell
    }
}

extension RecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0, 1:
            return posterList[collectionView.tag].count
        case 2:
            return relatePosterList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = RecommendCollectionViewCell.identifier
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        var posterPath: String?
        switch collectionView.tag {
        case 0, 1:
            posterPath = posterList[collectionView.tag][indexPath.item].poster_path
        case 2:
            posterPath = relatePosterList[indexPath.item].file_path
        default:
            break
        }
        if let posterPath = posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            cell.posterView.kf.setImage(with: url)
        }
        return cell
    }
}

extension RecommendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch collectionView.tag {
        case 0, 1:
            return CGSize(width: 110, height: 160)
        case 2:
            return CGSize(width: 180, height: 260)
        default:
            return CGSize(width: 120, height: 160)
        }
    }
}

extension RecommendViewController: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return RecommendCollectionViewCell.identifier
    }
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch skeletonView.tag {
        case 0, 1:
            return 5
        case 2:
            return 5
        default:
            return 0
        }
    }
}
