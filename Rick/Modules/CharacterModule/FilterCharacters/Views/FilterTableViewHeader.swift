//
//  FilterTableViewHeader.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 24.07.2022.
//

import Foundation
import UIKit

protocol FilterHeaderProtocol: AnyObject {
    func tapResetButton(section: Int)
}

class FilterTableViewHeader: UITableViewHeaderFooterView {

    let filterHeaderId = "filterHeaderId"
    weak var filterHeaderDelegate: FilterHeaderProtocol?
    var headerSection = 0

    private let headerNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .specialGreen
        label.font = .specialFont18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.titleLabel?.font = .specialFont18()
        button.tintColor = .red
        button.alpha = 0.5
        button.setTitleColor(.red, for: .disabled)
        button.isEnabled = false
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundView?.backgroundColor = .blue

        addSubview(headerNameLabel)
        addSubview(resetButton)
    }

    public func getHeaderName(name: String) {
        setHeaderName(name: name)
    }

    private func setHeaderName(name: String) {
        headerNameLabel.text = name
    }

    @objc private func resetButtonTapped() {
        filterHeaderDelegate?.tapResetButton(section: headerSection)
    }

// MARK: - Set constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            resetButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            resetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            resetButton.widthAnchor.constraint(equalToConstant: 60),

            headerNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerNameLabel.trailingAnchor.constraint(equalTo: resetButton.leadingAnchor, constant: -20)
        ])
    }
}
