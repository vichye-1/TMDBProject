//
//  SearchCollectionViewCell.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/11/24.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {
    
    private let posterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        configureCollectionViewCellHierarchy()
        configureCollectionViewLayout()
        configureImage()
        // posterImageView.backgroundColor = .blue
    }
    
    private func configureCollectionViewCellHierarchy() {
        addSubview(posterImageView)
    }
    
    private func configureCollectionViewLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureImage() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
