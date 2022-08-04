//
//  String+extension.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 23.07.2022.
//

import Foundation

extension String {
    func containsIgnoringCase(find: String) -> Bool {
        self.range(of: find, options: .caseInsensitive) != nil
    }
}
