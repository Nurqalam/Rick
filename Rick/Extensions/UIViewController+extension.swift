//
//  UIViewController+extension.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 23.07.2022.
//

import UIKit

extension UIViewController {

    func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {

        let button = UIButton(type: .system)
        button.setImage(
            UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        button.addTarget(self, action: selector, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
