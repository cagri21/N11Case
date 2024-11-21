//
//  ProductsView+CollectionDelegateExt.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 21.11.2024.
//

import NetworkProvider
import UIKit

extension ProductsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let sectionType: SectionType = presenter.sectionType(at: indexPath.section)

        if case .sponsored(let products) = sectionType {
                if let pagerView = productsCollectionView.supplementaryView(
                    forElementKind: UICollectionView.elementKindSectionFooter,
                    at: IndexPath(item: 0, section: indexPath.section)
                ) as? SectionPagerView {
                    pagerView.configure(with: products.count, currentPage: indexPath.row)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            DLog("\(ProductsViewController.self): cell couln't find in cell at didSelectItemAt.")
            return
        }

        // Trigger fade animation
        cell.animateFade { [weak self] in
            guard let self = self else {
                DLog("\(ProductsViewController.self): Self couln't find in cell click animation.")
                return
            }
            // Get the selected product
            let selectedProduct: ProductDisplayable = presenter.product(at: indexPath)

            // Delegate the selection to the presenter
            presenter.didSelectProduct(selectedProduct)
        }
        // Get the section type for the selected item
    }
}
