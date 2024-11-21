//
//  ProductDetailCollectionViewCell.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 21.11.2024.
//

import UIKit

class ProductDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()

        // Reset visibility for labels and views
        productImage.image = nil
        productImage.sd_cancelCurrentImageLoad()
    }

    func configure(with image: String) {
        // Set image
        if !image.isEmpty {
            productImage.downloadImage(url: image)
        }
    }
}
