//
//  BaseProductCell.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 19.11.2024.
//

import Cosmos
import NetworkProvider
import SDWebImage
import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(with data: DataType)
}

class BaseProductCell: UICollectionViewCell, ConfigurableCell {
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        // Reset visibility for labels and views
        titleLabel.isHidden = false
        priceLabel.isHidden = false
        discountPriceLabel.isHidden = true
        productImageView.isHidden = false
        rateView.isHidden = true

        // Reset texts and images
        titleLabel.text = nil
        priceLabel.text = nil
        discountPriceLabel.text = nil
        productImageView.image = nil
        productImageView.sd_cancelCurrentImageLoad()
        rateView.rating = 0

        // Reset additional properties
        priceLabel.attributedText = nil
        priceLabel.textColor = UIColor.productDiscountPrice // Reset to default text color
    }

    func configure(with product: ProductDisplayable) {
        // Set title
        titleLabel.text = product.title

        // Set price
        priceLabel.text = CurrencyFormatter.turkey.format(price: product.price)
        if let discountedPrice = product.instantDiscountPrice {
            discountPriceLabel.isHidden = false
            priceLabel.strikeThrough(true)
            discountPriceLabel.text = CurrencyFormatter.turkey.format(price: discountedPrice)
        } else {
            priceLabel.strikeThrough(false)
            priceLabel.textColor = UIColor.productNormalPrice
        }

        // Set rating
        if let rate = product.rate {
            rateView.rating = rate
            rateView.isHidden = false
        }

        // Set seller name (optional)

        // Set image
        if !product.image.isEmpty {
            productImageView.downloadImage(url: product.image)
        }
    }
}
