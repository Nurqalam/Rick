//
//  CharacterModel.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 23.07.2022.
//

import Foundation

struct CharacterModel: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
}
