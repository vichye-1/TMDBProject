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
        label.backgroundColor = .red
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .orange
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    private let movieView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let posterImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureTableViewCellHierarchy()
        configureTableViewCellLayOut()
    }
    
    private func configureTableViewCellHierarchy() {
        contentView.addSubview(dateLabel)
    }
    
    private func configureTableViewCellLayOut() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.width.equalTo(80)
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
