//
//  ProductDetail+CollectionData.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 21.11.2024.
//

import UIKit

extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductDetailCollectionViewCell = detailCollectionView.dequeueReusableCell(for: indexPath)
        let productImage: String = presenter.productImage(at: indexPath)
        cell.configure(with: productImage)
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numberOfSection: Int = presenter.numberOfSections()
        return numberOfSection
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems: Int = presenter.numberOfItems()
        return numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let pagerView: SectionPagerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionPagerView().className, for: indexPath) as! SectionPagerView
        pagerView.configure(with: presenter.numberOfItems(), currentPage: 0) // Start with the first page
        return pagerView
    }

}
