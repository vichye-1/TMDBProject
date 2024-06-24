//
//  NetworkManager.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/24/24.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchMovies(completionHandler: @escaping ([MovieResult]) -> Void) {
        
    }
}
