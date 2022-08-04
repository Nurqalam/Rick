//
//  DetailViewController.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 24.07.2022.
//

import Foundation
import UIKit

class  DetailViewController: UIViewController {

    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let categoryNameLabel = CategoryLabel(text: "Name:", textColor: .specialGreen)
    private let categoryStatusLabel = CategoryLabel(text: "Status:", textColor: .specialGreen)
    private let categorySpeciesLabel = CategoryLabel(text: "Species:", textColor: .specialGreen)
    private let categoryGenderLabel = CategoryLabel(text: "Gender:", textColor: .specialGreen)

    private let nameCharacterLabel = CategoryLabel(text: "Name1:", textColor: .white)
    private let statusLabel = CategoryLabel(text: "Status1:", textColor: .white)
    private let speciesLabel = CategoryLabel(text: "Species1:", textColor: .white)
    private let genderLabel = CategoryLabel(text: "Gender1:", textColor: .white)

    private var nameStackView = UIStackView()
    private var statusStackView = UIStackView()
    private var speciesStackView = UIStackView()
    private var genderStackView = UIStackView()
    private var parametersStackView = UIStackView()

    var character: CharacterStruct?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setContraints()
        setCharacter()
    }

    private func setupViews() {
        view.backgroundColor = .specialBackground
        title = character?.characterData.name

        view.addSubview(characterImageView)

        nameStackView = UIStackView(arrangedSubviews: [categoryNameLabel, nameCharacterLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        statusStackView = UIStackView(arrangedSubviews: [categoryStatusLabel, statusLabel],
                                      axis: .horizontal,
                                      spacing: 10)
        speciesStackView = UIStackView(arrangedSubviews: [categorySpeciesLabel, speciesLabel],
                                       axis: .horizontal,
                                       spacing: 10)
        genderStackView = UIStackView(arrangedSubviews: [categoryGenderLabel, genderLabel],
                                      axis: .horizontal,
                                      spacing: 10)
        parametersStackView = UIStackView(arrangedSubviews: [nameStackView,
                                                             statusStackView,
                                                             speciesStackView,
                                                             genderStackView],
                                          axis: .vertical,
                                          spacing: 15)
        view.addSubview(parametersStackView)
    }

    private func setCharacter() {
        guard let character = character else { return }
        characterImageView.image = character.characterImage
        nameCharacterLabel.text = character.characterData.name
        statusLabel.text = character.characterData.status
        speciesLabel.text = character.characterData.species
        genderLabel.text = character.characterData.gender
    }

// MARK: - Set constraints
    private func setContraints() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            characterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            characterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            characterImageView.heightAnchor.constraint(equalTo: view.widthAnchor),

            categoryNameLabel.widthAnchor.constraint(equalToConstant: categoryNameLabel.textSizeWidth() + 2),
            categoryStatusLabel.widthAnchor.constraint(equalToConstant: categoryStatusLabel.textSizeWidth() + 2),
            categorySpeciesLabel.widthAnchor.constraint(equalToConstant: categorySpeciesLabel.textSizeWidth() + 2),
            categoryGenderLabel.widthAnchor.constraint(equalToConstant: categoryGenderLabel.textSizeWidth() + 2),

            parametersStackView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 30),
            parametersStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}
