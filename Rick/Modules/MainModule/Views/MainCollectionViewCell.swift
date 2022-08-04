//
//  MainCollectionViewCell.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 22.07.2022.
//

import Foundation
import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    let cellMainID = "cellMainID"

    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.alpha = 0.5
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameCategoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .specialFont22()
        label.textColor = .specialBlack
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
        addSubview(nameCategoryLabel)
    }

    private func setConfigForCell(imageName: String, categoryName: String) {
        backImageView.image = UIImage(named: imageName)
        nameCategoryLabel.text = categoryName
    }

    public func getConfigForCell(imageName: String, categoryName: String) {
        setConfigForCell(imageName: imageName, categoryName: categoryName)
    }

// MARK: - Set constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            backImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            backImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),

            nameCategoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameCategoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameCategoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)

        ])
    }
}
