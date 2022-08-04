//
//  LocationsTableView.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 26.07.2022.
//

import Foundation
import UIKit

protocol LocationTableViewProtocol: AnyObject {
    func selectItem(location: LocationStruct)
    func loadingMoreLocations()
}

class LocationsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    weak var locationCellDelegate: LocationTableViewProtocol?

    var locationsArray = [LocationStruct]()
    var filteredLocationsArray = [LocationStruct]()
    var isFiltered = false

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        delegate = self
        dataSource = self
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        register(LocationsTableViewCell.self,
                 forCellReuseIdentifier: "cell")
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if contentOffset > contentHeight - height {
            locationCellDelegate?.loadingMoreLocations()
        }
    }

// MARK: - DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltered ? filteredLocationsArray.count : locationsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                       for: indexPath) as? LocationsTableViewCell else {
            return UITableViewCell()
        }
        if isFiltered {
            cell.nameLocationLabel.text = filteredLocationsArray[indexPath.row].locationData.name
            cell.typeLocationLabel.text = filteredLocationsArray[indexPath.row].locationData.type
        } else {
            cell.nameLocationLabel.text = locationsArray[indexPath.row].locationData.name
            cell.typeLocationLabel.text = locationsArray[indexPath.row].locationData.type
        }
        return cell
    }

// MARK: - Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationCellDelegate?.selectItem(location: locationsArray[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height / 11
    }
}
