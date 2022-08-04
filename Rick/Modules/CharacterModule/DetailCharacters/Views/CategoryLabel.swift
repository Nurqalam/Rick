//
//  CategoryLabel.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 24.07.2022.
//

import Foundation
import UIKit

class CategoryLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    convenience init(text: String, textColor: UIColor) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = textColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        textColor = .specialGreen
        translatesAutoresizingMaskIntoConstraints = false
    }

    public func textSizeWidth() -> CGFloat {
        guard let categoryFont: UIFont = .specialFont18() else { return 0 }
        let categoryAttributes = [NSAttributedString.Key.font: categoryFont as Any]
        let categoryWidth = self.text!.size(withAttributes: categoryAttributes).width
        return categoryWidth
    }
}
