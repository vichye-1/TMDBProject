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
    
    override func configureHierarchy() {
        [actorImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        actorImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView).inset(8)
            make.leading.equalTo(contentView).offset(16)
            make.width.equalTo(actorImageView.snp.height).multipliedBy(0.75)
        }
    }
}
