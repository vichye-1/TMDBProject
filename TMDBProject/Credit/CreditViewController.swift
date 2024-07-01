//
//  CreditViewController.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/29/24.
//

import UIKit
import Kingfisher
import SnapKit

class CreditViewController: BaseViewController {
    
    let overviewIdentifier = OverViewTableViewCell.identifier
    let castIdentifier = CastTableViewCell.identifier
    
    var selectedMovie: MovieResult?
    var casts: [Cast]?
    var overview = ""
    
    private let posterImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let posterBackgroundImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.alpha = 0.4
        return imageView
    }()
    
    private let movieTitleLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Constant.Font.bold20
        label.textColor = .white
        return label
    }()
    
    private let castTableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        [posterImageView, posterBackgroundImageView, movieTitleLabel, castTableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        posterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.25)
        }
        
        posterBackgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(posterImageView)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(34)
        }
        
        castTableView.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        guard let selectedMovie = selectedMovie else { return }
        movieTitleLabel.text = selectedMovie.title
        
        guard let posterPath = selectedMovie.poster_path else {
            posterImageView.image = UIImage(systemName: "timer")
            return
        }
        
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        posterImageView.kf.setImage(with: posterUrl)
        castTableView.reloadData()
    }
    
    override func configureTableView() {
        castTableView.delegate = self
        castTableView.dataSource = self
        castTableView.register(CastTableViewCell.self, forCellReuseIdentifier: castIdentifier)
        castTableView.register(OverViewTableViewCell.self, forCellReuseIdentifier: overviewIdentifier)
    }
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CreditType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let creditType = CreditType.allCases[section]
        return creditType.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let creditType = CreditType.allCases[section]
        switch creditType {
        case .overview:
            return 1
        case .cast:
            return casts?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = CreditType.allCases[indexPath.section]
        switch section {
        case .overview:
            let cell = tableView.dequeueReusableCell(withIdentifier: overviewIdentifier, for: indexPath) as! OverViewTableViewCell
            cell.overviewLabel.text = overview
            return cell
        case .cast:
            let cell = tableView.dequeueReusableCell(withIdentifier: castIdentifier, for: indexPath) as! CastTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let eachSection = CreditType.allCases[indexPath.section]
        switch eachSection {
        case .overview:
            return 150
        case .cast:
            return 80
        }
    }
    
    
}
