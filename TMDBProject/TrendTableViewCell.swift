//
//  TrendTableViewCell.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/10/24.
//

import UIKit
import SnapKit

class TrendTableViewCell: UITableViewCell {

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "12/10/2020"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "#Mystery"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .black)
        label.textColor = .black
        return label
    }()
    
    private let movieView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.cornerRadius = 9
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemYellow
        image.layer.cornerRadius = 9
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return image
    }()
    
    private let rateStrLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemPurple
        label.text = "평점"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    private let rateNumLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "3.3"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
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
    }
    
    private func configureTableViewCellLayOut() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
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
            make.height.equalTo(movieView.snp.height).multipliedBy(0.7)
        }
        
        rateStrLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImage.snp.leading).offset(20)
            make.bottom.equalTo(posterImage.snp.bottom).inset(20)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
        rateNumLabel.snp.makeConstraints { make in
            make.leading.equalTo(rateStrLabel.snp.trailing)
            make.bottom.equalTo(posterImage.snp.bottom).inset(20)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
