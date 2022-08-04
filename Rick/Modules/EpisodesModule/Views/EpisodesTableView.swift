//
//  EpisodesTableView.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 26.07.2022.
//

import Foundation
import UIKit

protocol EpisodeTableViewProtocol: AnyObject {
    func selectItem(episode: EpisodeStruct)
    func loadingMoreLocations()
}

class EpisodesTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    weak var episodeCellDelegate: EpisodeTableViewProtocol?

    var episodesArray = [EpisodeStruct]()
    var filteredEpisodesArray = [EpisodeStruct]()
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
        register(EpisodesTableViewCell.self,
                 forCellReuseIdentifier: "cell")
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let height = scrollView.frame.size.height
        let contentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if contentOffset > contentHeight - height {
            episodeCellDelegate?.loadingMoreLocations()
        }
    }

// MARK: - DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltered ? filteredEpisodesArray.count : episodesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                as? EpisodesTableViewCell else {
            return UITableViewCell()
        }
        if isFiltered {
            cell.nameEpisodeLabel.text = filteredEpisodesArray[indexPath.row].episodeData.name
            cell.typeEpisodeLabel.text = filteredEpisodesArray[indexPath.row].episodeData.episode
        } else {
            cell.nameEpisodeLabel.text = episodesArray[indexPath.row].episodeData.name
            cell.typeEpisodeLabel.text = episodesArray[indexPath.row].episodeData.episode
        }
        return cell
    }

// MARK: - Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        episodeCellDelegate?.selectItem(episode: episodesArray[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height / 11
    }
}
