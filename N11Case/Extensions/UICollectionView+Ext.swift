//
//  UICollectionView+Ext.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 17.11.2024.
//

import UIKit

extension UICollectionView {
    // Generic method to register a UICollectionViewCell
    func register<Cell: UICollectionViewCell>(_ cellType: Cell.Type) {
        let identifier: String = String(describing: cellType)
        self.register(cellType, forCellWithReuseIdentifier: identifier)
    }

    // Generic method to dequeue a UICollectionViewCell
    func dequeueReusableCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        let identifier: String = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error: Unable to dequeue UICollectionViewCell with identifier \(identifier)")
        }
        return cell
    }

    func registerNib<T: UICollectionViewCell>(for cellType: T.Type) {
        let className: String = String(describing: cellType)
        let nib: UINib = UINib(nibName: className, bundle: nil)
            self.register(nib, forCellWithReuseIdentifier: className)
    }
}
