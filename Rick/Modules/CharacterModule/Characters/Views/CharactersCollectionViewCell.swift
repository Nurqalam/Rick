//
//  CharactersCollectionViewCell.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 23.07.2022.
//

import Foundation
import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {

    static let characterCellId = "characterCellId"

    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.5
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let nameCharacterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = "Character"
        label.font = .specialFont22()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 20

        addSubview(backImageView)
        addSubview(nameView)
        addSubview(nameCharacterLabel)
    }

// MARK: - SetConstraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            backImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            backImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),

            nameView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            nameView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            nameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            nameView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),

            nameCharacterLabel.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
            nameCharacterLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 10),
            nameCharacterLabel.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -10)
        ])
    }
}
