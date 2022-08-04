//
//  NetworkImageFetch.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 23.07.2022.
//

import Foundation

class NetworkImageFetch {

    static let shared = NetworkImageFetch()
    private init() {}

    func requestImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {

        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
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
