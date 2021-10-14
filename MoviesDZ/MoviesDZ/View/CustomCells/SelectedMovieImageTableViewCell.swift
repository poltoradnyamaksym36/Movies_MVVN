// SelectedMovieImageTableViewCell.swift
// Copyright © VTB. All rights reserved.

import UIKit

final class SelectedMovieImageTableViewCell: UITableViewCell {
    static let identifier = "SelectedMovieImageTableViewCell"

    // MARK: - Private Properties

    private let chosenMoviePosterImageView = UIImageView()
    private let descriptionLabel = UILabel()

    // MARK: - Private methods

    func configure(movie: Movie) {
        DispatchQueue.global().async {
            let urlString = "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"
            guard let url = URL(string: urlString) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            guard let posterImage = UIImage(data: imageData) else { return }
            DispatchQueue.main.async {
                self.chosenMoviePosterImageView.image = posterImage
            }
        }
    }

    override func layoutSubviews() {
        constraints()
    }

    private func constraints() {
        chosenMoviePosterImageView.contentMode = .scaleAspectFill
        chosenMoviePosterImageView.clipsToBounds = true
        addSubview(chosenMoviePosterImageView)
        chosenMoviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chosenMoviePosterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            chosenMoviePosterImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            chosenMoviePosterImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            chosenMoviePosterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
