//
//  EpisodesViewController.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 26.07.2022.
//

import Foundation
import UIKit

class EpisodesViewController: UIViewController, EpisodeTableViewProtocol, UISearchResultsUpdating {

    private let emptyResponseView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "emptyResponse")
        imageView.backgroundColor = .specialBackground
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let episodesTableView = EpisodesTableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var page = 1
    private let delay = 1 // for loadingView
    var loadingView = LoadingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setDelegates()
        setupSearchController()
        requestEpisodes(page: page)
    }

    private func setupViews() {
        view.addSubview(episodesTableView)
        episodesTableView.frame = view.bounds
        episodesTableView.backgroundColor = .specialBackground
        title = "Episodes"
    }

    private func setDelegates() {
        episodesTableView.episodeCellDelegate = self
    }

// MARK: - LoadingView
    private func showLodingView() {
        view.addSubview(loadingView)
        loadingView.frame = view.bounds
    }
    private func hideLoading() {
        loadingView.removeFromSuperview()
    }

// MARK: - RequestEpisodes
    private func requestEpisodes(page: Int) {
        self.showLodingView()
        NetworkDataFetch.shared.fetchEpisode(page: page, dataType: "episode") { [weak self] result, _ in
            guard let self = self else { return }

            if let result = result {
                for (value) in result.results {
                    let episode = EpisodeStruct(episodeData: value)
                    self.episodesTableView.episodesArray.append(episode)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(self.delay),
                                                  execute: { () -> Void in
                        self.hideLoading()
                    })
                    self.episodesTableView.reloadData()
                }
            } else {
                self.emptyResponseView.isHidden = false
                self.navigationItem.rightBarButtonItem = nil
            }
        }
    }

// MARK: - SearchController
    private func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Введите название серии"
        searchController.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.356777114, green: 0.3733340979, blue: 0.4016773761, alpha: 1)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.text = .none
    }

// MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text != "" {
            episodesTableView.isFiltered = true
            episodesTableView.filteredEpisodesArray = [EpisodeStruct]()

            for episode in episodesTableView.episodesArray {
                if episode.episodeData.name.containsIgnoringCase(find: text) {
                    episodesTableView.filteredEpisodesArray.append(episode)
                }
            }
        } else {
            episodesTableView.isFiltered = false
        }
        episodesTableView.reloadData()
    }

// MARK: - LocationsTableViewProtocol
    func selectItem(episode: EpisodeStruct) {
        print(episode.episodeData.characters.count)
    }

    func loadingMoreLocations() {
        page += 1
        requestEpisodes(page: page)
    }

}
