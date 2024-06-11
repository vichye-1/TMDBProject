//
//  UICollectionViewCell+.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/11/24.
//

import UIKit

extension UICollectionViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
