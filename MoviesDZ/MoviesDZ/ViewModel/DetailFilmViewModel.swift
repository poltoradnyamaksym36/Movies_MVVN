// DetailFilmViewModel.swift
// Copyright © VTB. All rights reserved.

import Foundation

protocol DetailFilmViewModelProtocol {
    var movieDetail: Movie? { get set }
    var updateViewData: (() -> ())? { get set }
    func fetchDetailMovieFill(movieID: Int?)
    var movieID: Int? { get set }
}

final class MovieDetailViewModel: DetailFilmViewModelProtocol {
    var movieDetail: Movie?
    var updateViewData: (() -> ())?
    var movieID: Int?

    init(movieDetail: Movie?, movieID: Int?) {
        self.movieDetail = movieDetail
        self.movieID = movieID
        fetchDetailMovieFill(movieID: movieID)
    }

    func fetchDetailMovieFill(movieID: Int?) {
        guard let url =
            URL(
                string: """
                https://api.themoviedb.org/3/movie/\(movieID ??
                    0)?api_key=7502b719af3e4c9ad68d80658e7b83ed&language=ru-RU
                """
            )
        else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
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
