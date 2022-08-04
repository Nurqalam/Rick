//
//  LocationModel.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 26.07.2022.
//

import Foundation

struct LocationModel: Decodable {
    let results: [Location]
}

struct Location: Decodable {
    let name: String
    let residents: [String]
    let type: String
}
