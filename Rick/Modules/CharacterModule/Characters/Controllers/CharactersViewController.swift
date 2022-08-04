//
//  CharactersViewController.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 22.07.2022.
//

import Foundation
import UIKit

class CharactersViewController: UIViewController, UISearchResultsUpdating, CharactersCollectionViewProtocol {

    private let emptyResponseView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "emptyResponse")
        imageView.backgroundColor = .specialBackground
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let charactersCollectionView = CharactersCollectionVIew()
    private let searchController = UISearchController()
    private var page = 1
    private let delay = 1 // for loadingView

    var filterParameters = FilterParameters()
    var loadingView = LoadingView()

// MARK: - App Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        emptyResponseView.isHidden = true
        setupNavigationController()
        setupSearchController()
        applyFilterParameters()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDelegates()
        setContraints()
        requestCharacters(page: page)
    }

    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(charactersCollectionView)
        view.addSubview(emptyResponseView)
    }

    private func setupDelegates() {
        charactersCollectionView.characterCellDelegate = self
    }

// MARK: - NavigationController
    private func setupNavigationController() {
        title = "Characters"
        navigationItem.backButtonTitle = ""

        let filterRightButton = createCustomButton(imageName: "filter",
                                                   selector: #selector(filterTapped))
        navigationItem.rightBarButtonItem = filterRightButton
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    @objc private func filterTapped() {
        let filterViewController = FilterViewController()
        filterViewController.filterParameters = filterParameters
        navigationController?.pushViewController(filterViewController, animated: true)
    }

// MARK: - LoadingView
    private func showLodingView() {
        view.addSubview(loadingView)
        loadingView.frame = view.bounds
    }
    private func hideLoading() {
        loadingView.removeFromSuperview()
    }

// MARK: - SearchController
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Введите имя"
        searchController.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.356777114, green: 0.3733340979, blue: 0.4016773761, alpha: 1)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.text = .none
    }

// MARK: - RequestCharacters
    private func requestCharacters(page: Int) {
        self.showLodingView()
        NetworkDataFetch.shared.fetchCharacter(page: page, dataType: "character") { [weak self] result, error in
            guard let self = self else { return }

            if let result = result {
                for (index, value) in result.results.enumerated() {
                    let character = CharacterStruct(characterData: value, characterImage: nil)
                    self.charactersCollectionView.charactersArray.append(character)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(self.delay),
                                                  execute: { () -> Void in
                        self.hideLoading()
                    })
                    self.charactersCollectionView.reloadData()

                    NetworkImageFetch.shared.requestImage(url: value.image) { response in
                        switch response {
                        case .success(let data):
                            guard let image = UIImage(data: data) else { return }
                            self.charactersCollectionView.charactersArray[
                                self.charactersCollectionView.charactersArray.count - result.results.count + index
                            ].characterImage = image
                            self.charactersCollectionView.reloadData()
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            } else {
                self.emptyResponseView.isHidden = false
                self.navigationItem.rightBarButtonItem = nil
            }
        }
    }

// MARK: - FilterParameters
    // swiftlint:disable for_where
    private func applyFilterParameters() {
        charactersCollectionView.isFiltered = filterParameters.isFiltred
        charactersCollectionView.filteredCharactersArray = []

        if let gender = filterParameters.gender, let status = filterParameters.status {
            for character in charactersCollectionView.charactersArray {
                if character.characterData.status == status && character.characterData.gender == gender {
                    charactersCollectionView.filteredCharactersArray.append(character)
                }
            }
        } else if let status = filterParameters.status {
            for character in charactersCollectionView.charactersArray {
                if character.characterData.status == status {
                    charactersCollectionView.filteredCharactersArray.append(character)
                }
            }
        } else if let gender = filterParameters.gender {
            for character in charactersCollectionView.charactersArray {
                if character.characterData.gender == gender {
                    charactersCollectionView.filteredCharactersArray.append(character)
                }
            }
        }
        charactersCollectionView.reloadData()
    }

// MARK: - CharactersCollectionViewProtocol
    func selectItem(character: CharacterStruct) {
        let detailViewController = DetailViewController()
        detailViewController.character = character
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    func loadingMoreCharacters() {
        page += 1
        requestCharacters(page: page)
    }

// MARK: - UISearchResultsUpdating
    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        if text != "" {
            charactersCollectionView.isFiltered = true
            charactersCollectionView.filteredCharactersArray = [CharacterStruct]()

            if let gender = filterParameters.gender, let status = filterParameters.status {
                for character in charactersCollectionView.charactersArray {
                    if character.characterData.name.containsIgnoringCase(find: text) &&
                        character.characterData.status == status &&
                        character.characterData.gender == gender {
                        charactersCollectionView.filteredCharactersArray.append(character)
                    }
                }
            } else if let status = filterParameters.status {
                for character in charactersCollectionView.charactersArray {
                    if character.characterData.name.containsIgnoringCase(find: text) &&
                        character.characterData.status == status {
                        charactersCollectionView.filteredCharactersArray.append(character)
                    }
                }
            } else if let gender = filterParameters.gender {
                for character in charactersCollectionView.charactersArray {
                    if character.characterData.name.containsIgnoringCase(find: text) &&
                        character.characterData.gender == gender {
                        charactersCollectionView.filteredCharactersArray.append(character)
                    }
                }
            } else {
                for character in charactersCollectionView.charactersArray {
                    if character.characterData.name.containsIgnoringCase(find: text) {
                        charactersCollectionView.filteredCharactersArray.append(character)
                    }
                }
            }
        } else if filterParameters.isFiltred {
            if let gender = filterParameters.gender, let status = filterParameters.status {
                for character in charactersCollectionView.charactersArray {
                    if character.characterData.status == status &&
                        character.characterData.gender == gender {
                        charactersCollectionView.filteredCharactersArray.append(character)
                    }
                }
            } else if let gender = filterParameters.gender {
                for character in charactersCollectionView.charactersArray {
                    if character.characterData.gender == gender {
                        charactersCollectionView.filteredCharactersArray.append(character)
                    }
                }
            } else if let status = filterParameters.status {
                for character in charactersCollectionView.charactersArray {
                    if character.characterData.status == status {
                        charactersCollectionView.filteredCharactersArray.append(character)
                    }
                }
            }
        } else {
            charactersCollectionView.isFiltered = false
        }
        charactersCollectionView.reloadData()
    }

// MARK: - Set constraints
    private func setContraints() {
        NSLayoutConstraint.activate([
            charactersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            charactersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            charactersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            charactersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

            emptyResponseView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            emptyResponseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            emptyResponseView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            emptyResponseView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
