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
    
    var movies: [MovieResult] = []
    var casts: [Int: [Cast]] = [:]
    var genres: [Int: String] = [:]
    var overview = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        callRequestGenre()
        callRequestMovie()
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.triangle"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        view.backgroundColor = .white
    }
    
    @objc private func searchButtonTapped() {
        let searchVC = SearchCollectionViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    private func callRequestMovie() {
        let url = APIUrl.tmdbTrendingMovie.urlString
        let parameters: Parameters = [
            "language": "ko-KR"
        ]
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": APIKey.tmdbAccessToken
        ]
        AF.request(url, method: .get, parameters: parameters, headers: header).responseDecodable(of: TrendingMovie.self)
        { response in
            switch response.result {
            case .success(let value):
                self.movies = value.results
                self.movieTableView.reloadData()
                self.loadMovieId()
            case .failure(let error):
                print("movie \(error)")
            }
        }
    }
    private func loadMovieId() {
        for movie in movies {
            callRequestCredit(movie.id)
        }
    }
    
    private func callRequestCredit(_ movieId: Int) {
        let url = APIUrl.tmdbMovieCredit(id: movieId).urlString
        let parameters: Parameters = [
            "language": "ko-KR"
        ]
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": APIKey.tmdbAccessToken
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: header).responseDecodable(of: Credit.self) { response in
            switch response.result {
            case .success(let value):
                self.casts[movieId] = value.cast
                self.movieTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func callRequestGenre() {
        print(#function)
        let url = APIUrl.tmdbGenre.urlString
        let parameter: Parameters = [
            Constant.ParameterKey.language : Constant.ParameterValue.korean
        ]
        let header: HTTPHeaders = [
            Constant.HeaderKey.accept: APIKey.accept,
            Constant.HeaderKey.authorization: APIKey.tmdbAccessToken
        ]
        AF.request(url, method: .get, parameters: parameter, headers: header).responseDecodable(of: Genres.self) { response in
            switch response.result {
            case .success(let value):
                for genre in value.genres {
                    self.genres[genre.id] = genre.name
                }
                self.movieTableView.reloadData()
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
        movieTableView.separatorStyle = .none
    }
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = TrendTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TrendTableViewCell
        let movie = movies[indexPath.row]
        let cast = casts[movie.id] ?? []
        cell.configureCell(movie, cast, genres)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let creditVC = CreditViewController()
        let selectedMovie = movies[indexPath.row]
        creditVC.selectedMovie = selectedMovie
        creditVC.casts = casts[selectedMovie.id]
        creditVC.overview = selectedMovie.overview
        navigationController?.pushViewController(creditVC, animated: true)
    }
}
