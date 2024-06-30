//
//  CreditViewController.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/29/24.
//

import UIKit
import SnapKit

class CreditViewController: BaseViewController {
    
    let castIdentifier = CastTableViewCell.identifier
    
    private let posterImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        return imageView
    }()
    
    private let movieTitleLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Constant.Font.bold17
        label.textColor = .white
        label.backgroundColor = .systemCyan
        return label
    }()
    
    private let castTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemTeal
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        [posterImageView, movieTitleLabel, castTableView].forEach {
            view.addSubview($0)
        }
    }
    override func configureLayout() {
        
        posterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.25)
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
    override func configureTableView() {
        castTableView.delegate = self
        castTableView.dataSource = self
        castTableView.register(CastTableViewCell.self, forCellReuseIdentifier: castIdentifier)
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
            return 8
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: castIdentifier, for: indexPath) as! CastTableViewCell
        return cell
    }
    
    
}
