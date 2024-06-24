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
    var currentQuery: String?
    
    private let movieSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색하고 싶은 영화 이름을 적어주세요"
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
        configureHierarchy()
        configureLayout()
        configureUI()
        
        movieSearchBar.delegate = self
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        
        searchCollectionView.prefetchDataSource = self
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
    
    
    private func callRequestSearch(query: String? = nil) {
        print(#function)
        let url = APIUrl.tmdbSearch.urlString
        var parameters: Parameters = [
            "language": "ko-KR",
            "page": "\(page)"
        ]
        if let query = query, !query.isEmpty {
            parameters["query"] = query
        }
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": APIKey.tmdbAccessToken
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: header).responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let value):
                if self.page == 1 {
                    self.searchList = value
                } else {
                    self.searchList.results.append(contentsOf: value.results)
                }
                self.searchCollectionView.reloadData()
            case .failure(let error):
                self.errorAlert(title: "Error!", message: "네트워크 통신이 원활하지 않습니다", ok: "확인")
                print(error)
            }
        }
    }
}

extension SearchCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        guard let keyWord = movieSearchBar.text, !keyWord.isEmpty else { return }
        currentQuery = keyWord
        callRequestSearch(query: keyWord)
    }
    
}

extension SearchCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        let searchData = searchList.results[indexPath.row]
        cell.configureCollectionViewCell(searchData)
        return cell
    }
}

extension SearchCollectionViewController: UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if searchList.results.count - 2 == item.row {
                page += 1
                if let query = currentQuery {
                    callRequestSearch(query: query)
                } else {
                    callRequestSearch()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("Cancel prefetch \(indexPaths)")
    }
}
