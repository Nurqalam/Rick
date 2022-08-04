//
//  FilterTableViewCell.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 24.07.2022.
//

import Foundation
import UIKit

class FilterTableViewCell: UITableViewCell {

    let filterCellId = "filterCellId"

    private let checkView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let typeLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        checkView.layer.cornerRadius = checkView.frame.width / 2
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            checkView.backgroundColor = .specialGreen
            typeLabel.textColor = .specialGreen
        } else {
            checkView.backgroundColor = .white
            typeLabel.textColor = .white
        }
    }

    private func configure() {
        backgroundColor = .specialBackground
        selectionStyle = .none

        addSubview(checkView)
        addSubview(typeLabel)
    }

    private func setTypeName(typeName: String) {
        typeLabel.text = typeName
    }

    public func getTypeName(typeName: String) {
        setTypeName(typeName: typeName)
    }

// MARK: - Set constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            checkView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            checkView.heightAnchor.constraint(equalToConstant: frame.height / 2),
            checkView.widthAnchor.constraint(equalToConstant: frame.height / 2),

            typeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: checkView.trailingAnchor, constant: 10),
            typeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
