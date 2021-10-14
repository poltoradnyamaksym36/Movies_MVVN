// DetailFilmViewController.swift
// Copyright © VTB. All rights reserved.

import UIKit

final class DetailFilmViewController: UIViewController {
    // MARK: - Private Properties

    private let imageCellID = SelectedMovieImageTableViewCell.identifier
    private let descriptionCellID = DetailFilmTableViewCell.identifier
    private var movieList: Movie?
    private let chosenMovieTableView: UITableView = {
        let chosenMovieTableView = UITableView()
        chosenMovieTableView.translatesAutoresizingMaskIntoConstraints = false
        chosenMovieTableView.register(
            SelectedMovieImageTableViewCell.self,
            forCellReuseIdentifier: "SelectedMovieImageTableViewCell"
        )
        chosenMovieTableView.register(DetailFilmTableViewCell.self, forCellReuseIdentifier: "DetailFilmTableViewCell")
        return chosenMovieTableView
    }()

    // MARK: - Public Properties

    var movieID = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        chosenMovieTableView.delegate = self
        chosenMovieTableView.dataSource = self
        subviews()
        constraints()
        fetchFill()
    }

    // MARK: - Private Methods

    private func subviews() {
        view.addSubview(chosenMovieTableView)
    }

    private func constraints() {
        NSLayoutConstraint.activate([
            chosenMovieTableView.topAnchor.constraint(equalTo: view.topAnchor),
            chosenMovieTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            chosenMovieTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            chosenMovieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchFill() {
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
                self.movieList = try JSONDecoder()
                    .decode(Movie.self, from: data ?? Data()) // во 2 экране вместо movieList парсим Result
                DispatchQueue.main.async {
                    self.chosenMovieTableView.reloadData()
                    print("reloadData")
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

// MARK: - UITableViewDataSource

extension DetailFilmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = movieList else { return UITableViewCell() }
        switch indexPath.row {
        case 0:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: imageCellID,
                    for: indexPath
                ) as? SelectedMovieImageTableViewCell
            else { return UITableViewCell() }
            cell.configure(movie: movie)
            return cell

        case 1:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: descriptionCellID,
                    for: indexPath
                ) as? DetailFilmTableViewCell else { return UITableViewCell() }
            cell.descriptionText = movie.overview
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension DetailFilmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
}
