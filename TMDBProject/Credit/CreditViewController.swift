//
//  CreditViewController.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/29/24.
//

import UIKit
import SnapKit

class CreditViewController: BaseViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        [posterImageView, movieTitleLabel].forEach {
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
    }
}
