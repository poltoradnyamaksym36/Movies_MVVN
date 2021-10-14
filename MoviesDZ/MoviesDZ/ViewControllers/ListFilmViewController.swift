// ListFilmViewController.swift
// Copyright © VTB. All rights reserved.

import UIKit
/// FirstView
class ListFilmViewController: UIViewController {
    // MARK: Private Properties

    private var filmTableView = UITableView()
    private var arrayListFilms: [Results] = []
    private let listFilmTableViewCellID = ListFilmTableViewCell.identifier

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(filmTableView)
        navigationItem.title = "Movies"

        filmTableView.translatesAutoresizingMaskIntoConstraints = false
        filmTableView.register(ListFilmTableViewCell.self, forCellReuseIdentifier: listFilmTableViewCellID)
        filmTableView.backgroundColor = .white
        filmTableView.dataSource = self
        filmTableView.delegate = self
        setConstraints()
        fetchData()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            filmTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filmTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filmTableView.topAnchor.constraint(equalTo: view.topAnchor),
            filmTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchData() {
        guard let url =
            URL(
                string: "https://api.themoviedb.org/3/movie/popular?api_key=8a8ef26b18b57682681f9e71bfc3d836&language=ru-RU&page=1"
            )
        else { return }

        let session = URLSession.shared

        session.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let decodeData = try JSONDecoder().decode(ListFilm.self, from: data)
                self.arrayListFilms = decodeData.results
                DispatchQueue.main.async {
                    self.filmTableView.reloadData()
                }
            } catch {
                print("Error!!!!!!!!!!", error.localizedDescription)
            }
        }.resume()
    }
}

// MARK: - UITableViewDataSource

extension ListFilmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayListFilms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: listFilmTableViewCellID, for: indexPath) as? ListFilmTableViewCell
        else { return UITableViewCell() }

        DispatchQueue.global().async {
            guard let poster = self.arrayListFilms[indexPath.row].posterPath else { return }

            guard let urlImage =
                URL(
                    string: "https://image.tmdb.org/t/p/w500\(poster)"
                )
            else { return }
            guard let imageData = try? Data(contentsOf: urlImage) else { return }
            guard let image = UIImage(data: imageData) else { return }

            DispatchQueue.main.async {
                cell.movieImageView.image = image
            }
        }

        cell.labelText.text = arrayListFilms[indexPath.row].overview
        cell.titleLabel.text = arrayListFilms[indexPath.row].title
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListFilmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieID = arrayListFilms[indexPath.row].id else { return }
        let vc = DetailFilmViewController()
        vc.movieID = movieID
        navigationController?.pushViewController(vc, animated: true)
    }
}
