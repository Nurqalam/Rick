//
//  FilterTableView.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 24.07.2022.
//

import Foundation
import UIKit

class FilterTableView: UITableView, UITableViewDataSource, UITableViewDelegate, FilterHeaderProtocol {

    private let headersArray = ["Status", "Gender"]
    private let filterArray = [
        ["Alive", "Dead", "Unknown"],
        ["Female", "Male", "Genderless", "Unknown"]
    ]

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .plain)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {

        delegate = self
        dataSource = self

        register(FilterTableViewCell.self,
                 forCellReuseIdentifier: FilterTableViewCell().filterCellId)
        register(FilterTableViewHeader.self,
                 forHeaderFooterViewReuseIdentifier: FilterTableViewHeader().filterHeaderId)

        backgroundColor = .none
        delaysContentTouches = false
        separatorStyle = .none
        bounces = false
        allowsMultipleSelection = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func enableResetButton(alpha: CGFloat, isEnable: Bool, section: Int) {
        guard let header = self.headerView(forSection: section) as? FilterTableViewHeader else { return }
        header.resetButton.isEnabled = isEnable
        header.resetButton.alpha = alpha
    }

// MARK: - DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        headersArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? filterArray[0].count : filterArray[1].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell().filterCellId,
                                                       for: indexPath) as? FilterTableViewCell else {
            return UITableViewCell()
        }
        let typeName = indexPath.section == 0 ? filterArray[0][indexPath.row] : filterArray[1][indexPath.row]
        cell.getTypeName(typeName: typeName)
        return cell
    }

// MARK: - Delegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FilterTableViewHeader().filterHeaderId)
            as? FilterTableViewHeader
        header?.getHeaderName(name: headersArray[section])
        header?.headerSection = section
        header?.filterHeaderDelegate = self
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedRows = tableView.indexPathsForSelectedRows else { return }
        for index in selectedRows {
            if indexPath.section == index.section && index.row != indexPath.row {
                deselectRow(at: index, animated: true)
            }
        }
        enableResetButton(alpha: 1, isEnable: true, section: indexPath.section)
    }

// MARK: - FilterHeaderProtocol
    func tapResetButton(section: Int) {
        for row in 0..<filterArray[section].count {
            deselectRow(at: [section, row], animated: true)
        }
        enableResetButton(alpha: 0.5, isEnable: false, section: section)
    }
}
