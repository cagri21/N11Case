//
//  NormalProductCell.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 17.11.2024.
//

import Cosmos
import NetworkProvider
import SDWebImage
import UIKit

class NormalProductCell: BaseProductCell {
    @IBOutlet weak var sellerLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        sellerLabel.text = nil
    }

    override func configure(with product: any ProductDisplayable) {
        super.configure(with: product)

        rateView.settings.starSize = 15

        guard let product = product as? Product else {
            DLog("\(UserDefaults.self): Invalid product type.")
            return
        }
        sellerLabel.text = product.sellerName
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
