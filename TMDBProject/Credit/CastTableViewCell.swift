//
//  CastTableViewCell.swift
//  TMDBProject
//
//  Created by 양승혜 on 7/1/24.
//

import UIKit
import SnapKit

class CastTableViewCell: BaseTableViewCell {
    let actorImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        return imageView
    }()
    
    let actorNameLabel = {
        let label = UILabel()
        label.backgroundColor = .systemGreen
        label.textColor = .black
        label.font = Constant.Font.bold15
        label.textAlignment = .left
        return label
    }()
    
    let characterLabel = {
        let label = UILabel()
        label.backgroundColor = .systemBlue
        label.textColor = .gray
        label.font = Constant.Font.font13
        label.textAlignment = .left
        return label
    }()
    
    override func configureHierarchy() {
        [actorImageView, actorNameLabel, characterLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        actorImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView).inset(8)
            make.leading.equalTo(contentView).offset(16)
            make.width.equalTo(actorImageView.snp.height).multipliedBy(0.75)
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
