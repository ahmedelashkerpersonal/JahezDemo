//
//  JahezCollectionView.swift
//  JahezDemo
//
//  Created by Ahmed Elashker on 17/01/2023.
//

import UIKit

final class JahezCollectionView: UICollectionView {
    
    static let cellIdentifier = "JahezCell"
    
    //MARK: - Collection View Setup
    enum CollectionViewSection: CaseIterable {
        case main
    }
    
    lazy var diffableDataSource: UICollectionViewDiffableDataSource<CollectionViewSection, RestaurantWithImage> = {
        
            let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, RestaurantWithImage> { [weak self] (cell, _, restaurant) in
                
                var content = cell.defaultContentConfiguration()
                content.text = restaurant.restaurant.name
                content.textProperties.color = .systemTeal
                content.textProperties.font = UIFont.preferredFont(forTextStyle: .title1)
                
                content.image = restaurant.image
                content.imageProperties.maximumSize = .init(width: 50, height: 80)

                cell.contentConfiguration = content
                cell.accessories = [.disclosureIndicator()]
            }

            return UICollectionViewDiffableDataSource<CollectionViewSection, RestaurantWithImage> (collectionView: self) { [weak self] (collectionView, indexPath, restaurant) -> UICollectionViewCell? in
                collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                             for: indexPath,
                                                             item: restaurant)
            }
        }()
    
    func applySnapshot(restaurants: [RestaurantWithImage], animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, RestaurantWithImage>()
        snapshot.appendSections(CollectionViewSection.allCases)
        snapshot.appendItems(restaurants)
        self.diffableDataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
}
