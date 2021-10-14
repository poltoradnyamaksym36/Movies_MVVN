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

    func fetchData() {
        guard let url =
            URL(
                string: "https://api.themoviedb.org/3/movie/popular?api_key=8a8ef26b18b57682681f9e71bfc3d836&language=ru-RU&page=1"
            )
        else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let decodeData = try JSONDecoder().decode(ListFilm.self, from: data)
                self.results = decodeData.results
                self.updateViewData?()
            } catch {
                print("Error", error.localizedDescription)
            }
        }.resume()
    }
}
