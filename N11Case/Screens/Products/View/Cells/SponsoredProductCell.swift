//
//  SponsoredProductCell.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 17.11.2024.
//

import Cosmos
import NetworkProvider
import SDWebImage
import UIKit

class SponsoredProductCell: UICollectionViewCell {

    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset visibility for stack views and labels
        titleLabel.isHidden = false
        priceLabel.isHidden = false
        discountPriceLabel.isHidden = false // Discount label is hidden by default
        productImageView.isHidden = false
        rateView.isHidden = true
        discountPriceLabel.isHidden = true

        // Reset label texts
        titleLabel.text = nil
        priceLabel.text = nil
        discountPriceLabel.text = nil

        // Reset image view
        productImageView.image = nil
        productImageView.sd_cancelCurrentImageLoad() // Cancel any ongoing image downloads

        // Reset additional properties if any
        priceLabel.attributedText = nil
        priceLabel.textColor = UIColor.productDiscountPrice // Reset to default text color
    }


    func configure(with product: SponsoredProduct) {
        titleLabel.text = product.title
        priceLabel.text = CurrencyFormatter.turkey.format(price: product.price)
        rateView.settings.starSize = 15

        if let discountedPrice = product.instantDiscountPrice {
            discountPriceLabel.isHidden = false
            priceLabel.strikeThrough(true)
            discountPriceLabel.text = CurrencyFormatter.turkey.format(price: discountedPrice)
        } else {
            priceLabel.strikeThrough(false)
            priceLabel.textColor = UIColor.productNormalPrice
        }

        if let rate = product.rate {
            rateView.rating = rate
            rateView.isHidden = false
        }

        if !product.image.isEmpty {
            productImageView.downloadImage(url: product.image)
        }
    }

}
