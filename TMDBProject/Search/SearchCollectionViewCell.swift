//
//  SearchCollectionViewCell.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/11/24.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {
    
    let posterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        configureCollectionViewCellHierarchy()
        configureCollectionViewLayout()
    }
    
    private func configureCollectionViewCellHierarchy() {
        addSubview(posterImageView)
    }
    
    private func configureCollectionViewLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCollectionViewCell(_ searchResult: searchResults) {
        guard let searchPosterPath = searchResult.poster_path else {
            posterImageView.image = UIImage(systemName: "questionmark.square.dashed")
            posterImageView.tintColor = .darkGray
            return
        }
        let searchPosterURL = URL(string: "https://image.tmdb.org/t/p/w500\(searchPosterPath)")
        posterImageView.kf.setImage(with: searchPosterURL)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
