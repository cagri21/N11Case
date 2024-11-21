//
//  CollectionViewLayoutProvider.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 16.11.2024.
//

import NetworkProvider
import UIKit

/// Protocol for horizontal layout sections
protocol HorizontalSectionProvider {
    func createSection(environment: NSCollectionLayoutEnvironment, isSponsored: Bool) -> NSCollectionLayoutSection
}

/// Protocol for vertical layout sections
protocol VerticalSectionProvider {
    func createSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection
}

/// Layout provider for sponsored products section
final class HorizontalProductsLayoutProvider: HorizontalSectionProvider {
    func createSection(environment: NSCollectionLayoutEnvironment, isSponsored: Bool) -> NSCollectionLayoutSection {
        let itemSpace: CGFloat = 10
        let containerWidth: CGFloat = environment.container.contentSize.width - itemSpace
        var containerHeight: CGFloat = environment.container.contentSize.height

        if isSponsored {
            containerHeight /= 4
        } else {
            containerHeight *= 0.9
        }

        // Define the item size (fills the entire screen horizontally and vertically)
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(containerWidth ),
            heightDimension: .absolute(containerHeight)
        )
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: itemSpace / 2, bottom: 0, trailing: itemSpace / 2)

        // Define the group size (same as item size)
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(containerWidth),
            heightDimension: .absolute(containerHeight)
        )
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        // Section configuration
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging // Enables paging for one item per screen
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: itemSpace / 2,
            bottom: 0,
            trailing: itemSpace / 2
        )

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
}

/// Layout provider for normal products section
final class VerticalProductsLayoutProvider: VerticalSectionProvider {
    func createSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let totalWidth: CGFloat = environment.container.contentSize.width
        let spacing: CGFloat = 10 // Space between items and edges
        let itemWidth: CGFloat = (totalWidth - (3 * spacing)) / 2 // Subtract 3 spacings (1 for leading, 1 for middle, 1 for trailing)

        // Item size (height is 1.8 times the width)
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemWidth),
            heightDimension: .absolute(itemWidth * 1.8) // Height is 1.8 times the width
        )
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

        // Group size (spans two items horizontally in one row)
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(totalWidth),
            heightDimension: .absolute(itemWidth * 1.8) // Height matches the item height
        )
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(spacing)

        // Section settings
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: spacing,
            leading: spacing,
            bottom: spacing,
            trailing: spacing
        )
        return section
    }
}

/// Protocol for layout providers
protocol CollectionViewLayoutProvider {
    func createCompositionalLayout() -> UICollectionViewLayout
    func createHorizontalLayout() -> UICollectionViewLayout
}

/// Concrete layout provider implementation
final class CustomProductLayoutProvider: CollectionViewLayoutProvider {
    private let horizontalSectionProvider: HorizontalSectionProvider
    private let verticalSectionProvider: VerticalSectionProvider

    init(horizontalSectionProvider: HorizontalSectionProvider = HorizontalProductsLayoutProvider(),
         verticalSectionProvider: VerticalSectionProvider = VerticalProductsLayoutProvider()) {
        self.horizontalSectionProvider = horizontalSectionProvider
        self.verticalSectionProvider = verticalSectionProvider
    }

    func createCompositionalLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, environment in
            sectionIndex == 0
                ? self.horizontalSectionProvider.createSection(environment: environment, isSponsored: true)
            : self.verticalSectionProvider.createSection(environment: environment)
        }
    }

    func createHorizontalLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { _ , environment in
            self.horizontalSectionProvider.createSection(environment: environment, isSponsored: false)
        }
    }
}
