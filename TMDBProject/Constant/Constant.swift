//
//  Constant.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/12/24.
//

import UIKit

enum Constant {
    enum Font {
        static let font13 = UIFont.systemFont(ofSize: 13)
        static let font15 = UIFont.systemFont(ofSize: 15)
        static let bold15 = UIFont.systemFont(ofSize: 15)
        static let bold17 = UIFont.systemFont(ofSize: 17, weight: .bold)
        static let bold20 = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    enum ParameterKey {
        static let language = "language"
    }
    enum HeaderKey {
        static let accept = "accept"
        static let authorization = "Authorization"
    }
    enum ParameterValue {
        static let korean = "ko-KR"
    }
    enum headerValue {
        static let acceptValue = "application/json"
    }
}
