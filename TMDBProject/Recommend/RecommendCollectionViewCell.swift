//
//  RecommendCollectionViewCell.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/25/24.
//

import UIKit
import SnapKit

class RecommendCollectionViewCell: UICollectionViewCell {
    let posterView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemMint
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureHierarchy()
        configureLayout()
    }
    private func configureHierarchy() {
        contentView.addSubview(posterView)
    }
    private func configureLayout() {
        posterView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
