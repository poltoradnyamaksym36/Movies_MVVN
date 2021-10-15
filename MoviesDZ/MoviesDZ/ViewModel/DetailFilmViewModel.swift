// DetailFilmViewModel.swift
// Copyright © VTB. All rights reserved.

import Foundation

protocol DetailFilmViewModelProtocol {
    func fetchDetailMovieFill()
    var movieDetail: Movie? { get set }
    var movieID: Int? { get set }
    var updateViewData: (() -> ())? { get set }
}

final class MovieDetailViewModel: DetailFilmViewModelProtocol {
    var movieID: Int?
    var movieDetail: Movie?
    var updateViewData: (() -> ())?

    func fetchDetailMovieFill() {
        guard let url =
            URL(
                string: """
                https://api.themoviedb.org/3/movie/\(movieID)?api_key=7502b719af3e4c9ad68d80658e7b83ed&language=ru-RU
                """
            )
        else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            do {
                self.movieDetail = try JSONDecoder().decode(Movie.self, from: data ?? Data())
                DispatchQueue.main.async {
                    self.updateViewData?()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
