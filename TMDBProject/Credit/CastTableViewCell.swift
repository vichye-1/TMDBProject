//
//  CastTableViewCell.swift
//  TMDBProject
//
//  Created by 양승혜 on 7/1/24.
//

import UIKit
import SnapKit

class CastTableViewCell: BaseTableViewCell {
    private let imageShadowView = {
        let view = UIView()
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 8
        view.layer.shadowColor = UIColor.gray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let actorImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let actorNameLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Constant.Font.bold15
        label.textAlignment = .left
        return label
    }()
    
    let characterLabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = Constant.Font.font13
        label.textAlignment = .left
        return label
    }()
    
    override func configureHierarchy() {
        imageShadowView.addSubview(actorImageView)
        [imageShadowView, actorNameLabel, characterLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        imageShadowView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView).inset(8)
            make.leading.equalTo(contentView).offset(16)
            make.width.equalTo(actorImageView.snp.height).multipliedBy(0.75)
        }
        
        actorImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        actorNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(actorImageView.snp.trailing).offset(20)
            make.trailing.equalTo(contentView).inset(20)
            make.centerY.equalTo(contentView).offset(-10)
            make.height.equalTo(24)
        }
        
        characterLabel.snp.makeConstraints { make in
            make.leading.equalTo(actorImageView.snp.trailing).offset(20)
            make.trailing.equalTo(contentView).inset(20)
            make.centerY.equalTo(contentView).offset(10)
            make.height.equalTo(24)
        }
    }
}
