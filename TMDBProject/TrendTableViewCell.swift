//
//  TrendTableViewCell.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/10/24.
//

import UIKit

class TrendTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureTableViewCellHierarchy()
        configureTableViewCellLayOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableViewCellHierarchy() {
        
    }
    
    private func configureTableViewCellLayOut() {
        
    }

}
