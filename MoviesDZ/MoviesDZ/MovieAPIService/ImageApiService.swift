// ImageApiService.swift
// Copyright © VTB. All rights reserved.

import Foundation
import UIKit

///
protocol ImageApiServiceProtocol: AnyObject {
    func configure(movie: Movie, completion: @escaping (Result<UIImage, Error>) -> Void)
}

private var session = URLSession.shared

///
class ImageApiService: ImageApiServiceProtocol {
    func configure(movie: Movie, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let urlString = "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"

        DispatchQueue.global().async {
            guard let url = URL(string: urlString) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            guard let posterImage = UIImage(data: imageData) else { return }
            DispatchQueue.main.async {
                completion(.success(posterImage))
            }
        }
    }
}
