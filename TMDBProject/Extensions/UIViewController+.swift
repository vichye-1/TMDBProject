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

extension UIViewController {
    func errorAlert(title: String, message: String, ok: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yes = UIAlertAction(title: ok, style: .default)
        alert.addAction(yes)
        present(alert, animated: true)
    }
}
