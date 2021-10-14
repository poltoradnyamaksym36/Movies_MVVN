// Image.swift
// Copyright © VTB. All rights reserved.

import Foundation

struct ListFilm: Decodable {
    let page: Int
    let results: [Results]
    let total_results: Int
    let total_pages: Int
}

struct Results: Decodable {
    var poster_path: String?
    var adult: Bool?
    var overview: String
    var release_date: String
    var genre_ids: [Int]
    var id: Int
    var original_title: String
    var original_language: String
    var title: String
    var backdrop_path: String?
    var popularity: Int
    var vote_count: Int
    var video: Bool
    var vote_average: Int
}
