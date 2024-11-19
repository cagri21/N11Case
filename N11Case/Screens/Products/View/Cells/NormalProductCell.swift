//
//  NormalProductCell.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 17.11.2024.
//

import NetworkProvider
import SDWebImage
import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(with data: DataType)
}

class NormalProductCell: UICollectionViewCell, ConfigurableCell {


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
        // Reset visibility for stack views and labels
        titleLabel.isHidden = false
        priceLabel.isHidden = false
        discountPriceLabel.isHidden = false // Discount label is hidden by default
        productImageView.isHidden = false

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

    func configure(with product: ProductDisplayable) {
        titleLabel.text = product.title
        priceLabel.text = CurrencyFormatter.turkey.format(price: product.price)

        if let discountedPrice = product.instantDiscountPrice {
            discountPriceLabel.isHidden = false
            priceLabel.strikeThrough(true)
            discountPriceLabel.text = CurrencyFormatter.turkey.format(price: discountedPrice)
        } else {
            priceLabel.strikeThrough(false)
            priceLabel.textColor = UIColor.productNormalPrice
            discountPriceLabel.isHidden = true
        }

        if let rate = product.rate {

        } else {

        }

        if product.image.isEmpty {

        } else {
            productImageView.downloadImage(url: product.image)
        }
    }
    
    

    
}
extension UIImageView{
    func downloadImage(url:String){
      //remove space if a url contains.
        let stringWithoutWhitespace = url.replacingOccurrences(of: " ", with: "%20", options: .regularExpression)
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: stringWithoutWhitespace), placeholderImage: UIImage())
    }
}
