// Movie.swift
// Copyright © VTB. All rights reserved.

import Foundation
/// Model
struct Movie: Decodable {
    var page: Int?
    var results: [Result]
    var total_results: Int?
    var total_pages: Int?
}

/// Model
struct Result: Decodable {
    var poster_path: String?
    var adult: Bool
    var overview: String
    var release_date: String
    var genre_ids: [Int]
    var id: Int
    var original_title: String
    var original_language: String
    var title: String
    var backdrop_path: String?
    var popularity: Double
    var vote_count: Int
    var video: Bool
    var vote_average: Double
}
