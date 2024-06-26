//
//  CreditTableViewCell.swift
//  TMDBProject
//
//  Created by 양승혜 on 7/1/24.
//

import UIKit
import SnapKit

class OverViewTableViewCell: BaseTableViewCell {
    let overviewLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Constant.Font.font13
        label.numberOfLines = 0
        return label
    }()
    
    override func configureHierarchy() {
        [overviewLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        overviewLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView).inset(20)
        }
    }
}
