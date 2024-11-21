//
//  ProductsView+CollectionDelegateExt.swift.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 21.11.2024.
//

import UIKit

extension ProductDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let pagerView = detailCollectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionFooter,
            at: IndexPath(item: 0, section: indexPath.section)
        ) as? SectionPagerView {
                    pagerView.configure(with: presenter.numberOfItems(), currentPage: indexPath.row)
        }
    }
}
