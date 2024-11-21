//
//  UIImage+Ext.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 22.11.2024.
//

import UIKit
import NetworkProvider
import SDWebImage

extension UIImageView {
    /// Sets an image for a UIImageView using a URL string.
    /// - Parameters:
    ///   - url: The URL string of the image.
    ///   - placeholder: A placeholder image displayed while the image is loading.
    ///   - fallbackImage: An optional fallback image displayed if the loading fails.
    func setImage(url: String, placeholder: UIImage = UIImage(), fallbackImage: UIImage? = nil) {
        // Remove spaces if the URL contains any
        let stringWithoutWhitespace: String = url.replacingOccurrences(of: " ", with: "%20", options: .regularExpression)
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray

        // Attempt to download the image
        self.sd_setImage(
            with: URL(string: stringWithoutWhitespace),
            placeholderImage: placeholder,
            options: []
        ) { [weak self] image, error, _, _ in
            if let error = error {
                // Log the error
                Logger.error("Failed to load image: \(error.localizedDescription)")

                // Set fallback image if provided
                if let fallback = fallbackImage {
                    self?.image = fallback
                }
            } else if image == nil {
                // Set fallback image if no image was downloaded
                if let fallback = fallbackImage {
                    self?.image = fallback
                }
            }
        }
    }
}
