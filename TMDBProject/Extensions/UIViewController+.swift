//
//  UIViewController+.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/10/24.
//

import UIKit

extension UIViewController: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
