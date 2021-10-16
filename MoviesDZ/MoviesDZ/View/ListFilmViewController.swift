// ListFilmViewController.swift
// Copyright © VTB. All rights reserved.

import UIKit
/// FirstView
class ListFilmViewController: UIViewController {
    // MARK: - Private Properties

    private var filmTableView = UITableView()
    private var arrayListFilms: [Results] = []
    private let listFilmTableViewCellID = ListFilmTableViewCell.identifier

    var viewModel: MoviesViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(filmTableView)
        navigationItem.title = "Films"

        filmTableView.translatesAutoresizingMaskIntoConstraints = false
        filmTableView.register(ListFilmTableViewCell.self, forCellReuseIdentifier: listFilmTableViewCellID)
        filmTableView.backgroundColor = .white
        filmTableView.dataSource = self
        filmTableView.delegate = self
        setConstraints()

//        viewModel.fetchData()
//        reloadData()
        updateView()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            filmTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filmTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filmTableView.topAnchor.constraint(equalTo: view.topAnchor),
            filmTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupMoViewModel(viewModel: MoviesViewModelProtocol) {
        self.viewModel = viewModel
    }

//    func reloadData() {
//        viewModel.updateViewData = { [weak self] in
//            self?.filmTableView.reloadData()
//        }
//    }

    func updateView() {
        viewModel.fetchData()

        viewModel.updateViewData = { [weak self] in
            DispatchQueue.main.async {
                self?.filmTableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ListFilmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.results?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: listFilmTableViewCellID, for: indexPath) as? ListFilmTableViewCell
        else { return UITableViewCell() }

        let cellData = viewModel.results?[indexPath.row]
        cell.configureCell(withData: cellData)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListFilmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieID = viewModel.results?[indexPath.row].id else { return }

        let detailApiService = MovieApiService()

        // создал модель
        let detailFilmModel = MovieDetailViewModel(movieID: movieID, movieDetailApiService: detailApiService)

        // создал новый экран
        let detailVC = DetailFilmViewController(viewMovieDetailModel: detailFilmModel)

        navigationController?.pushViewController(detailVC, animated: true)
    }
}
