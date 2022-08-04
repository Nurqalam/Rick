//
//  LocationsViewController.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 26.07.2022.
//

import Foundation
import UIKit

class LocationsViewController: UIViewController, LocationTableViewProtocol, UISearchResultsUpdating {

    private let emptyResponseView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "emptyResponse")
        imageView.backgroundColor = .specialBackground
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let locationsTableView = LocationsTableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var page = 1
    private let delay = 1 // for loadingView
    var loadingView = LoadingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setDelegates()
        setupSearchController()
        requestLocations(page: page)
    }

    private func setupViews() {
        view.addSubview(locationsTableView)
        locationsTableView.frame = view.bounds
        locationsTableView.backgroundColor = .specialBackground
        title = "Locations"
    }

    private func setDelegates() {
        locationsTableView.locationCellDelegate = self
    }

// MARK: - LoadingView
        private func showLodingView() {
            view.addSubview(loadingView)
            loadingView.frame = view.bounds
        }
        private func hideLoading() {
            loadingView.removeFromSuperview()
        }

// MARK: - RequestLocations
    private func requestLocations(page: Int) {
        self.showLodingView()
        NetworkDataFetch.shared.fetchLocation(page: page, dataType: "location") { [weak self] result, _ in
            guard let self = self else { return }

            if let result = result {
                for (value) in result.results {
                    let location = LocationStruct(locationData: value)
                    self.locationsTableView.locationsArray.append(location)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(self.delay),
                                                  execute: { () -> Void in
                        self.hideLoading()
                    })
                    self.locationsTableView.reloadData()
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
        searchController.searchBar.placeholder = "Введите название локации"
        searchController.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.356777114, green: 0.3733340979, blue: 0.4016773761, alpha: 1)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.text = .none
    }

// MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text != "" {
            locationsTableView.isFiltered = true
            locationsTableView.filteredLocationsArray = [LocationStruct]()

            for location in locationsTableView.locationsArray {
                if location.locationData.name.containsIgnoringCase(find: text) {
                    locationsTableView.filteredLocationsArray.append(location)
                }
            }
        } else {
            locationsTableView.isFiltered = false
        }
        locationsTableView.reloadData()
    }

// MARK: - LocationsTableViewProtocol
    func selectItem(location: LocationStruct) {
        print(location.locationData.residents.count)
    }

    func loadingMoreLocations() {
        page += 1
        requestLocations(page: page)
    }
}
