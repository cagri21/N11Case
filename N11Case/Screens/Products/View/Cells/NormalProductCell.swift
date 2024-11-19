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
}

extension UIImageView{
    func downloadImage(url:String){
      //remove space if a url contains.
        let stringWithoutWhitespace = url.replacingOccurrences(of: " ", with: "%20", options: .regularExpression)
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: stringWithoutWhitespace), placeholderImage: UIImage())
    }
}
