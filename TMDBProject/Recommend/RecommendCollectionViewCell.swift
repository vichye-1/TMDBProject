//
//  RecommendCollectionViewCell.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/25/24.
//

import UIKit
import SkeletonView
import SnapKit

class RecommendCollectionViewCell: UICollectionViewCell {
    let posterView: UIImageView = {
        let image = UIImageView()
        image.isSkeletonable = true
        //image.backgroundColor = .systemMint
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(posterView)
        posterView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
