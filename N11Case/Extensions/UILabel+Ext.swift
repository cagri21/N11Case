//
//  UILabel+Ext.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 19.11.2024.
//

import UIKit

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
