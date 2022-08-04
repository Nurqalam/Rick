//
//  FilterViewController.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 24.07.2022.
//

import Foundation
import UIKit

class FilterViewController: UIViewController {

    private lazy var applyFiltersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Apply filters", for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.specialGreen.cgColor
        button.layer.cornerRadius = 10
        button.tintColor = .specialGreen
        button.titleLabel?.font = .specialFont18()
        button.addTarget(self, action: #selector(applyFiltersButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let filterTableView = FilterTableView()
    var filterParameters = FilterParameters()

// MARK: - App LifeCycle
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setFilterParameters()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setContraints()
    }

    private func setupViews() {
        view.backgroundColor = .specialBackground
        title = "Filter"

        view.addSubview(filterTableView)
        view.addSubview(applyFiltersButton)
    }

    @objc private func applyFiltersButtonTapped() {
        guard let charactersViewController = self.navigationController?.viewControllers[1]
                as? CharactersViewController else {
            return
        }

        if getFilterParameters().0 == nil && getFilterParameters().1 == nil {
            filterParameters.isFiltred = false
            filterParameters.status = getFilterParameters().0
            filterParameters.gender = getFilterParameters().1
            charactersViewController.filterParameters = filterParameters
        } else {
            filterParameters.isFiltred = true
            filterParameters.status = getFilterParameters().0
            filterParameters.gender = getFilterParameters().1
            charactersViewController.filterParameters = filterParameters
        }
        navigationController?.popViewController(animated: true)
    }

    private func getFilterParameters() -> (String?, String?) {
        var filterParameters: (String?, String?)
        guard let selectedRows = filterTableView.indexPathsForSelectedRows else {
            return (nil, nil)
        }

        selectedRows.forEach { index in
            switch index {
            case [0, 0] : filterParameters.0 = "Alive"
            case [0, 1] : filterParameters.0 = "Dead"
            case [0, 2] : filterParameters.0 = "Unknown"

            case [1, 0] : filterParameters.1 = "Female"
            case [1, 1] : filterParameters.1 = "Male"
            case [1, 2] : filterParameters.1 = "Genderless"
            case [1, 3] : filterParameters.1 = "Unknown"
            default:
                print("No filter parameters")
            }
        }
        return filterParameters
    }

    // swiftlint:disable cyclomatic_complexity
    private func setFilterParameters() {
        if let status = filterParameters.status {
            switch status {
            case "Alive":
                filterTableView.selectRow(at: [0, 0], animated: true, scrollPosition: .none)
            case "Dead":
                filterTableView.selectRow(at: [0, 1], animated: true, scrollPosition: .none)
            case "Unknown":
                filterTableView.selectRow(at: [0, 2], animated: true, scrollPosition: .none)
            default:
                print("Fail status")
            }
            getHeader(section: 0)
        }

        if let gender = filterParameters.gender {
            switch gender {
            case "Female":
                filterTableView.selectRow(at: [1, 0], animated: true, scrollPosition: .none)
            case "Male":
                filterTableView.selectRow(at: [1, 1], animated: true, scrollPosition: .none)
            case "Genderless":
                filterTableView.selectRow(at: [1, 2], animated: true, scrollPosition: .none)
            case "Unknown":
                filterTableView.selectRow(at: [1, 3], animated: true, scrollPosition: .none)
            default:
                print("Fail gender")
            }
            getHeader(section: 1)
        }
    }

    private func getHeader(section: Int) {
        guard let header = filterTableView.headerView(forSection: section) as? FilterTableViewHeader else { return }
        header.resetButton.isEnabled = true
        header.resetButton.alpha = 1
    }

// MARK: - Set constraints
    private func setContraints() {
        NSLayoutConstraint.activate([
            applyFiltersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            applyFiltersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            applyFiltersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            applyFiltersButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12),

            filterTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            filterTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            filterTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            filterTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
