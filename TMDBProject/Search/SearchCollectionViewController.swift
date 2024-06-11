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

final class SearchCollectionViewController: UIViewController {
    
    var searchList = Search(results: [], page: 0, total_pages: 0, total_results: 0)
    
    var page = 1
    
    private let movieSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    private let searchCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: searchCollectionViewLayout())
        return collectionView
    }()
    
    static func searchCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 36
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.5)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 8, bottom: 8, right: 8)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequestSearch(query: "factory")
        configureHierarchy()
        configureLayout()
        configureUI()
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
    
    private func configureHierarchy() {
        view.addSubview(movieSearchBar)
        view.addSubview(searchCollectionView)
    }
    
    private func configureLayout() {
        movieSearchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        searchCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(movieSearchBar.snp.bottom)
        }
    }
    
    private func configureUI() {
        navigationItem.title = "영화검색"
        navigationItem.titleView?.tintColor = .black
        view.backgroundColor = .white
    }
    
    
    private func callRequestSearch(query: String) {
        print(#function)
        let url = APIUrl.tmdbSearch.urlString
        let parameters: Parameters = [
            "query": "\(query)",
            "language": "ko-KR",
            "page": "\(page)"
        ]
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": APIKey.tmdbAccessToken
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: header).responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let value):
                self.searchList.results.append(contentsOf: value.results)
                self.searchCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        page = 1
        callRequestSearch(query: searchBar.text!)
    }
}

extension SearchCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        let searchData = searchList.results[indexPath.row]
        
        return cell
    }
}
