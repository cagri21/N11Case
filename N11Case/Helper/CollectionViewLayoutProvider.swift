//
//  CollectionViewLayoutProvider.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 16.11.2024.
//

import UIKit
import NetworkProvider

final class CompositionalLayoutProvider {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                // Sponsored Products Section (Horizontal Scroll)
                return CompositionalLayoutProvider.createHorizontalSection()
            default:
                // Normal Products Section (Vertical Scroll)
                return CompositionalLayoutProvider.createVerticalSection()
            }
        }
    }
    
    private static func createHorizontalSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                              heightDimension: .fractionalHeight(0.3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                               heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8)
        return section
    }
    
    private static func createVerticalSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                              heightDimension: .fractionalHeight(0.3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8)
        return section
    }
}

protocol CollectionViewLayoutProvider {
    func createLayout(hasSponsoredSection: Bool) -> UICollectionViewLayout
}

/// Class to generate UICollectionViewCompositionalLayout
final class ProductsCollectionViewLayoutProvider: CollectionViewLayoutProvider {

    func createLayout(hasSponsoredSection: Bool) -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            if hasSponsoredSection{
                return self.createSponsoredSectionLayout()
            } else {
                return self.createProductSectionLayout()
            }
        }
    }

    /// Layout for Sponsored Products (Horizontal Scrolling)
    private func createSponsoredSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
                
                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                       heightDimension: .fractionalHeight(0.4))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8)
                return section
    }

    /// Layout for Normal Products (Vertical Scrolling)
    private func createProductSectionLayout() -> NSCollectionLayoutSection {
        // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalWidth(0.5 * 2.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8)
                return section
    }
}
