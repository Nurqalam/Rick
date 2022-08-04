//
//  LocationsTableViewCell.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 26.07.2022.
//

import Foundation
import UIKit

class LocationsTableViewCell: UITableViewCell {

    let nameLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .specialFont22()
        label.textColor = .specialGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let typeLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .specialFont18()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var stackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.layer.borderWidth = 0.5
        stackView = UIStackView(arrangedSubviews: [nameLocationLabel,
                                                  typeLocationLabel],
                                axis: .vertical,
                                spacing: 10)
        addSubview(stackView)
    }

// MARK: - Set constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
