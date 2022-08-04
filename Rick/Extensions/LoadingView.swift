//
//  LoadingView.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 03.08.2022.
//

import Foundation
import UIKit

class LoadingView: UIView {
    private lazy var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    init() {
        super.init(frame: .zero)
        setupView()
        setConstraints()
    }

    private func setupView() {
        self.addSubview(blurEffectView)
        self.addSubview(loadingActivityIndicator)
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        insertSubview(blurEffectView, at: 0)
    }

// MARK: - SetConstraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            blurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blurEffectView.topAnchor.constraint(equalTo: self.topAnchor),

            loadingActivityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingActivityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
