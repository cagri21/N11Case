//
//  SponsoredProductCell.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 17.11.2024.
//

import NetworkProvider
import SDWebImage
import UIKit

class SponsoredProductCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset label text
        titleLabel.text = nil
        // Reset image view
        productImageView.image = nil
        // Reset additional cell properties if needed
        contentView.backgroundColor = .white
    }

    func configure(with product: ProductDisplayable) {
        titleLabel.text = product.title
        if product.image.isEmpty {
            
        } else {
            product.getImage { [weak self] Image in
                guard let self = self else {
                    return
                }
                self.productImageView.image = Image
            }
        }
    }

}
