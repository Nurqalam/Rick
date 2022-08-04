//
//  NetworkRequest.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 23.07.2022.
//

import Foundation

class NetworkRequest {

    static let shared = NetworkRequest()
    private init() {}

    func requestData(page: Int, dataType: String, completion: @escaping (Result<Data, Error>) -> Void) {

        let urlString = "https://rickandmortyapi.com/api/\(dataType)?page=\(page)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    }
}
