//
//  ViewController.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 22.07.2022.
//

import UIKit

class MainViewController: UIViewController, MainCollectionViewProtocol {

    let mainCollectionView = MainCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
        setDelegates()
    }

    private func setupViews() {
        view.backgroundColor = .specialBackground
        title = "Choose section"
        navigationItem.backButtonTitle = ""
        view.addSubview(mainCollectionView)
    }

    private func setDelegates() {
        mainCollectionView.mainCellDelegate = self
    }

    func selectItem(indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let charactersVC = CharactersViewController()
            navigationController?.pushViewController(charactersVC, animated: true)
        case 1:
            let locationsVC = LocationsViewController()
            navigationController?.pushViewController(locationsVC, animated: true)
        case 2:
            let episodesVC = EpisodesViewController()
            navigationController?.pushViewController(episodesVC, animated: true)
        default:
            print("tap \(indexPath.row)")
        }
    }

// MARK: - Set constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
