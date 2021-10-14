// ListFilmTableViewCell.swift
// Copyright © VTB. All rights reserved.

import UIKit
/// MyTableViewCell
class ListFilmTableViewCell: UITableViewCell {
    static let identifier = "ListFilmTableViewCell"

    // MARK: - Private Properties

    private var arrayMovie: [Results] = []

    // MARK: - Public Properties

    let titleLabel = UILabel()
    let labelText = UILabel()
    let movieImageView = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        createImage()
        createLabel()
        createTitleLabel()
    }

    // MARK: - Public Methods

    public func createLabel() {
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

    public func createImage() {
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

    public func createTitleLabel() {
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
