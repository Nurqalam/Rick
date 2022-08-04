//
//  NetworkDataFetch.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 23.07.2022.
//

import Foundation

class NetworkDataFetch {

    static let shared = NetworkDataFetch()
    private init() {}

    func fetchCharacter(page: Int, dataType: String, responce: @escaping (CharacterModel?, Error?) -> Void) {
        NetworkRequest.shared.requestData(page: page, dataType: dataType) { result in
            switch result {
            case .success(let data):
                do {
                    let character = try JSONDecoder().decode(CharacterModel.self, from: data)
                    responce(character, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }

    // locations
    func fetchLocation(page: Int, dataType: String, responce: @escaping (LocationModel?, Error?) -> Void) {
        NetworkRequest.shared.requestData(page: page, dataType: dataType) { result in
            switch result {
            case .success(let data):
                do {
                    let location = try JSONDecoder().decode(LocationModel.self, from: data)
                    responce(location, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }

    // episodes
    func fetchEpisode(page: Int, dataType: String, responce: @escaping (EpisodeModel?, Error?) -> Void) {
        NetworkRequest.shared.requestData(page: page, dataType: dataType) { result in
            switch result {
            case .success(let data):
                do {
                    let episode = try JSONDecoder().decode(EpisodeModel.self, from: data)
                    responce(episode, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
