//
//  RecommendCollectionViewCell.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/25/24.
//

import UIKit
import SnapKit

class RecommendCollectionViewCell: BaseCollectionViewCell {
    let posterView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    
    let progressLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        label.font = Constant.Font.bold15
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

    }
    
    override func configureHierarchy() {
        [posterView, progressLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        posterView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.edges.equalTo(posterView)
        }
    }
}
