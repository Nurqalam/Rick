//
//  CharactersCollectionVIew.swift
//  Rick & Morty - test3
//
//  Created by Nurqalam on 23.07.2022.
//

import Foundation
import UIKit

protocol CharactersCollectionViewProtocol: AnyObject {
    func selectItem(character: CharacterStruct)
    func loadingMoreCharacters()
}

class CharactersCollectionVIew: UICollectionView, UICollectionViewDelegateFlowLayout,
                                    UICollectionViewDelegate, UICollectionViewDataSource {

    weak var characterCellDelegate: CharactersCollectionViewProtocol?
    private var flowLayout = UICollectionViewFlowLayout()

    var charactersArray = [CharacterStruct]()
    var filteredCharactersArray = [CharacterStruct]()
    var isFiltered = false

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
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        register(CharactersCollectionViewCell.self,
                 forCellWithReuseIdentifier: CharactersCollectionViewCell.characterCellId)
        flowLayout.minimumLineSpacing = 25
        flowLayout.minimumInteritemSpacing = 15
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if contentOffset > contentHeight - height {
            characterCellDelegate?.loadingMoreCharacters()
        }
    }

// MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isFiltered ? filteredCharactersArray.count : charactersArray.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.characterCellId,
                                             for: indexPath) as? CharactersCollectionViewCell else {
            return UICollectionViewCell()
        }
        if isFiltered {
            cell.nameCharacterLabel.text = filteredCharactersArray[indexPath.row].characterData.name
            cell.backImageView.image = filteredCharactersArray[indexPath.row].characterImage
            return cell
        } else {
            cell.nameCharacterLabel.text = charactersArray[indexPath.row].characterData.name
            cell.backImageView.image = charactersArray[indexPath.row].characterImage
            return cell
        }
    }

// MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFiltered {
            characterCellDelegate?.selectItem(character: filteredCharactersArray[indexPath.row])
        } else {
            characterCellDelegate?.selectItem(character: charactersArray[indexPath.row])
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2.1,
               height: collectionView.frame.height / 3.7)
    }
}
