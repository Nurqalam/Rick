//
//  MainCollectionView.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 22.07.2022.
//

import Foundation
import UIKit

protocol MainCollectionViewProtocol: AnyObject {
    func selectItem(indexPath: IndexPath)
}

class MainCollectionView: UICollectionView, UICollectionViewDelegate,
                            UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    weak var mainCellDelegate: MainCollectionViewProtocol?
    private var flowLayout = UICollectionViewFlowLayout()

    private let configCellArray = [["characters", "locations", "episodes"],
                                   ["Characters", "Locations", "Episodes"]]

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        delegate = self
        dataSource = self
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        register(MainCollectionViewCell.self,
                 forCellWithReuseIdentifier: MainCollectionViewCell().cellMainID)
        flowLayout.minimumLineSpacing = 30
    }

// MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        configCellArray[0].count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell().cellMainID,
                                             for: indexPath) as? MainCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let imageName = configCellArray[0][indexPath.row]
        let categoryName = configCellArray[1][indexPath.row]
        cell.getConfigForCell(imageName: imageName, categoryName: categoryName)
        return cell
    }

// MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainCellDelegate?.selectItem(indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width,
               height: collectionView.frame.height / 3.70)
    }
}
