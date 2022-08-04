//
//  EpisodeModel.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 26.07.2022.
//

import Foundation

struct EpisodeModel: Codable {
    let results: [Episode]
}

struct Episode: Codable {
    let id: Int
    let name: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
