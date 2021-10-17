// Movie.swift
// Copyright © VTB. All rights reserved.

import Foundation
/// Movie Model
struct Movie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
