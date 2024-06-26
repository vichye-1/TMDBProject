//
//  UIView+.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/26/24.
//

import UIKit

extension UIView: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
