//
//  Movie.swift
//  TMDBProject
//
//  Created by 양승혜 on 6/10/24.
//


// 개봉 날짜, 장르, 사진, 평점, 영화 제목, 출연진
import Foundation

struct movie {
    let results: [movieResult]
}

struct movieResult {
    let poster_path: String
    let title: String
    let genre_ids: [Int]
    let release_date: String
    let vote_average: Double
}
