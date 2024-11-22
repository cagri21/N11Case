//
//  Untitled.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 21.11.2024.
//

import NetworkProvider
import UIKit

extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType: SectionType = presenter.sectionType(at: indexPath.section)
        let product: ProductDisplayable = presenter.product(at: indexPath)

        switch sectionType {
        case .sponsored:
            let cell: SponsoredProductCell = productsCollectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: product as! SponsoredProduct)
            return cell
        case .products:
            let cell: NormalProductCell = productsCollectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: product as! Product)
            return cell
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numberOfSection: Int = presenter.numberOfSections()
        return numberOfSection
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems: Int = presenter.numberOfItems(in: section)
        return numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionType: SectionType = presenter.sectionType(at: indexPath.section)
        // Check for Sponsored Section Footer
        if kind == UICollectionView.elementKindSectionFooter, case .sponsored(let products) = sectionType {
            // Create and configure the pager view for the sponsored section
            let pagerView: SectionPagerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionPagerView().className, for: indexPath) as! SectionPagerView
            pagerView.configure(with: products.count, currentPage: 0) // Start with the first page
            return pagerView
        }

        return UICollectionReusableView()
    }

}
