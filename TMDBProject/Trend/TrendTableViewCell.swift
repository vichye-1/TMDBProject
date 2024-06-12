//
//  TrendTableViewCell.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/10/24.
//

import UIKit
import SnapKit
import Kingfisher

class TrendTableViewCell: UITableViewCell {

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Constant.Font.font15
        label.textColor = .darkGray
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "#Mystery"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let movieView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 9
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.layer.cornerRadius = 9
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let rateStrLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemPurple
        label.text = "평점"
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    private let rateNumLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "3.3"
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Alice in borderland"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    private let dividerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkGray
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "자세히 보기"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private let nextImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .black
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureTableViewCellHierarchy()
        configureTableViewCellLayOut()
    }
    
    private func configureTableViewCellHierarchy() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(movieView)
        contentView.addSubview(posterImage)
        contentView.addSubview(rateStrLabel)
        contentView.addSubview(rateNumLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(actorsLabel)
        contentView.addSubview(dividerLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(nextImage)
    }
    
    private func configureTableViewCellLayOut() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(90)
            make.height.equalTo(28)
        }
        
        movieView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(movieView.snp.width)
        }
        
        posterImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(movieView)
            make.height.equalTo(movieView.snp.height).multipliedBy(0.6)
        }
        
        rateStrLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImage.snp.leading).offset(20)
            make.bottom.equalTo(posterImage.snp.bottom).inset(20)
            make.width.equalTo(36)
            make.height.equalTo(24)
        }
        
        rateNumLabel.snp.makeConstraints { make in
            make.leading.equalTo(rateStrLabel.snp.trailing)
            make.bottom.equalTo(posterImage.snp.bottom).inset(20)
            make.width.equalTo(36)
            make.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(movieView).inset(20)
            make.top.equalTo(posterImage.snp.bottom).offset(16)
            make.height.equalTo(30)
        }
        
        actorsLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(movieView).inset(20)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(28)
        }
        
        dividerLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(movieView).inset(20)
            make.top.equalTo(actorsLabel.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerLabel.snp.bottom).offset(16)
            make.leading.equalTo(movieView.snp.leading).offset(16)
            make.height.equalTo(20)
            make.width.equalTo(80)
        }
        
        nextImage.snp.makeConstraints { make in
            make.top.equalTo(dividerLabel.snp.bottom).offset(16)
            make.trailing.equalTo(movieView.snp.trailing).inset(16)
            make.height.width.equalTo(20)
        }
    }
    
    func configureCell(_ movie: MovieResult, _ casts: [Cast]) {
        dateLabel.text = movie.release_date
        titleLabel.text = movie.title
        rateNumLabel.text = String(format: "%.1f", movie.vote_average)
        actorsLabel.text = casts.map { $0.name }.joined(separator: ", ")
        // how to build an image URL : https://developer.themoviedb.org/docs/image-basics
        guard let posterPath = movie.poster_path else {
            posterImage.image = UIImage(systemName: "timer")
            return
        }
        let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        posterImage.kf.setImage(with: posterURL)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
