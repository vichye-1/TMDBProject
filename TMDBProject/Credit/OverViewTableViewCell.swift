//
//  CreditTableViewCell.swift
//  TMDBProject
//
//  Created by 양승혜 on 7/1/24.
//

import UIKit
import SnapKit

class OverViewTableViewCell: BaseTableViewCell {
    private let overviewTextView = {
        let textview = UITextView()
        textview.backgroundColor = .systemYellow
        textview.textColor = .black
        textview.font = Constant.Font.font13
        return textview
    }()
    
    override func configureHierarchy() {
        [overviewTextView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        overviewTextView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView).inset(20)
        }
    }
}
