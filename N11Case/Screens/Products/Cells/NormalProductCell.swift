//
//  NormalProductCell.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 17.11.2024.
//

import NetworkProvider
import SDWebImage
import UIKit

class NormalProductCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with product: ProductDisplayable) {
        titleLabel.text = product.title
        productImageView.sd_setImage(with: URL(string: product.imageURL), placeholderImage: UIImage(systemName: "photo"))
    }

}
