// MoviAPIService.swift
// Copyright © VTB. All rights reserved.

import Foundation
///
protocol MovieApiServiceProtocol {
    func fetchData(completion: @escaping ((Result<ListFilm, Error>) -> ())) // [ListFilm]
    func fetchDetailMovieFill(movieID: Int?, completion: @escaping (Result<Movie, Error>) -> ())
}

///
class MovieApiService: MovieApiServiceProtocol {
    func fetchData(completion: @escaping ((Result<ListFilm, Error>) -> ())) {
        guard let url =
            URL(
                string: "https://api.themoviedb.org/3/movie/popular?api_key=8a8ef26b18b57682681f9e71bfc3d836&language=ru-RU&page=1"
            )
        else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movieList = try decoder.decode(ListFilm.self, from: data)
                completion(.success(movieList))
                print(movieList.results)
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchDetailMovieFill(movieID: Int?, completion: @escaping (Result<Movie, Error>) -> ()) {
        guard let url =
            URL(
                string: """
                https://api.themoviedb.org/3/movie/\(movieID ??
                    0)?api_key=7502b719af3e4c9ad68d80658e7b83ed&language=ru-RU
                """
            )
        else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let details = try decoder.decode(Movie.self, from: data)
                completion(.success(details))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
