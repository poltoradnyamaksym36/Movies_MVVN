// DetailFilmViewModel.swift
// Copyright © VTB. All rights reserved.

import Foundation

protocol DetailFilmViewModelProtocol {
    var movieDetail: Movie? { get set }
    var updateViewData: (() -> ())? { get set }
    var movieID: Int? { get set }
    func getMovieDetails()
}

final class MovieDetailViewModel: DetailFilmViewModelProtocol {
    var movieDetail: Movie?
    var updateViewData: (() -> ())?
    var movieID: Int?

    private var movieDetailApiService: MovieApiServiceProtocol

    init(movieID: Int?, movieDetailApiService: MovieApiServiceProtocol) {
        self.movieID = movieID
        self.movieDetailApiService = movieDetailApiService
    }

    func getMovieDetails() {
        movieDetailApiService.fetchDetailMovieFill(movieID: movieID) { [weak self] result in
            switch result {
            case let .success(movieDetail):
                self?.movieDetail = movieDetail
                DispatchQueue.main.async {
                    self?.updateViewData?()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
