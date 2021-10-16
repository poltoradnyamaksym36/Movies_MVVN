// ListFilm.swift
// Copyright © VTB. All rights reserved.

import Foundation
/// Film Images Model
struct ListFilm: Codable {
    let results: [Results]
}

/// Film Images Model
struct Results: Codable {
    var posterPath: String?
    var adult: Bool?
    var overview: String
    var releaseDate: String?
    var id: Int?
    var originalTitle: String?
    var title: String?
    var backdropPath: String?
    var popularity: Float?
    var voteCount: Int?
    var voteAverage: Float?
}
