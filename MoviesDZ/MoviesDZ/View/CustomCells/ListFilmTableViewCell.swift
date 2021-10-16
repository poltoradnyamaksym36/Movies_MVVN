// ListFilmTableViewCell.swift
// Copyright © VTB. All rights reserved.

import UIKit
/// MyTableViewCell
class ListFilmTableViewCell: UITableViewCell {
    static let identifier = "ListFilmTableViewCell"

    // MARK: - Private Properties

    private let titleLabel = UILabel()
    private let labelText = UILabel()
    private let movieImageView = UIImageView()
    private let imageApiService = ImageApiService()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        createImage()
        createTitleLabel()
        createLabel()
    }

    func configureCell(withData data: Results?) { // Results
//        guard let data = data else { return }

        DispatchQueue.global().async {
            guard let data = data else { return }

            guard let urlImage = URL(string: "https://image.tmdb.org/t/p/w500\(data.posterPath ?? "")"),
                  let imageData = try? Data(contentsOf: urlImage) else { return }

            DispatchQueue.main.async {
                self.movieImageView.image = UIImage(data: imageData)
                self.labelText.text = data.overview
                self.titleLabel.text = data.title
            }
        }

//        imageApiService.configure(movie: data) { [weak self] result in
//            switch result {
//            case let .success(image):
//                self?.movieImageView.image = image
//            case let .failure(error):
//                print(error.localizedDescription)
//            }
//        }
//                self.labelText.text = data.overview
//                 self.titleLabel.text = data.title
    }

    func createLabel() {
        addSubview(labelText)
        labelText.numberOfLines = 0
        labelText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelText.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            labelText.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            labelText.bottomAnchor.constraint(equalTo: bottomAnchor),
            labelText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }

    func createImage() {
        addSubview(movieImageView)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 150),
            movieImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    func createTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 60),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 30),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
}
