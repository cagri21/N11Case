//
//  UILabel+Ext.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 19.11.2024.
//

import UIKit
import NetworkProvider

extension UILabel {
    func strikeThrough(_ isStrikeThrough: Bool) {
        guard let labelText = self.text, !labelText.isEmpty else {
            Logger.warning("Error: Unable to dequeue UICollectionViewCell with identifier")
            self.attributedText = nil
            return
        }

        if isStrikeThrough {
            // Apply strikethrough style
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: labelText)
            attributeString.addAttribute(
                .strikethroughStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(location: 0, length: attributeString.length)
            )
            self.attributedText = attributeString
        } else {
            // Remove strikethrough and restore plain text
            if let attributedStringText = self.attributedText?.string {
                self.attributedText = nil
                self.text = attributedStringText
            }
        }
    }
}
