// MovieViewModel.swift
// Copyright © VTB. All rights reserved.

import Foundation

protocol MoviesViewModelProtocol: AnyObject {
    var results: [Results]? { get set }
    var updateViewData: (() -> ())? { get set }
    func fetchData()
}

final class MovieViewModel: MoviesViewModelProtocol {
    var results: [Results]?
    var updateViewData: (() -> ())?

    private var movieApiService: MovieApiServiceProtocol

    init(movieApiService: MovieApiServiceProtocol) {
        self.movieApiService = movieApiService
        fetchData()
    }

    func fetchData() {
        movieApiService.fetchData { [weak self] result in
            switch result {
            case let .success(result):
                self?.results = result.results
                DispatchQueue.main.async {
                    self?.updateViewData?()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
