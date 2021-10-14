// DetailFilmTableViewCell.swift
// Copyright © VTB. All rights reserved.

import UIKit

final class DetailFilmTableViewCell: UITableViewCell {
    static let identifier = "DetailFilmTableViewCell"

    // MARK: - Private Properties

    private let descriptionFilmLabel = UILabel()

    // MARK: - Public Properties

    var descriptionText: String?

    override func layoutSubviews() {
        createFilmLabel()
        descriptionFilmLabel.text = descriptionText ?? ""
    }

    // MARK: - Private Properties

    private func createFilmLabel() {
        addSubview(descriptionFilmLabel)
        descriptionFilmLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionFilmLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            descriptionFilmLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            descriptionFilmLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionFilmLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
}
