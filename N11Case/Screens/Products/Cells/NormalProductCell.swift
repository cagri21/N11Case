//
//  NormalProductCell.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 17.11.2024.
//

import Cosmos
import NetworkProvider
import UIKit

final class NormalProductCell: BaseProductCell {
    @IBOutlet weak var sellerLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        sellerLabel.text = nil
    }

    override func configure(with product: any ProductDisplayable) {
        super.configure(with: product)

        rateView.settings.starSize = 15

        guard let product = product as? Product else {
            Logger.error("Invalid product type.")
            return
        }
        sellerLabel.text = product.sellerName
    }
}
