//
//  CollectionViewLayoutProvider.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 16.11.2024.
//

import UIKit
import NetworkProvider

final class CustomProductLayout {
    static func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            if sectionIndex == 0 {
                // Sponsored Products Section (Horizontal)
                return CustomProductLayout.createSponsoredProductsSection(environment: environment)
            } else {
                // Normal Products Section (Vertical)
                return CustomProductLayout.createNormalProductsSection(environment: environment)
            }
        }
    }

    private static func createSponsoredProductsSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Item
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

        // Group
        let groupHeight = environment.container.contentSize.height / 4  // Adjust to 1/4 of screen height
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(groupHeight)
        )
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        // Section
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging // Ensures one item per page
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        // Footer Supplementary View (Pager)
        let footerSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let footer: NSCollectionLayoutBoundarySupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        section.boundarySupplementaryItems = [footer]

        return section
    }

    private static func createNormalProductsSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Item size
        let itemWidth: Double = environment.container.contentSize.width / 2.2
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemWidth),
            heightDimension: .absolute(itemWidth * 2.0)
        )
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

        // Group
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(itemWidth * 2.0 + 5) // One row's height with spacing
        )
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)

        // Section
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        return section
    }
}

/// Protocol for layout providing, adhering to DIP
protocol CollectionViewLayoutProvider {
    func createLayout(hasSponsoredSection: Bool) -> UICollectionViewLayout
}
