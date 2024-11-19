//
//  RMScreenSizeAdjustingConstraint.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 19.11.2024.
//

import UIKit

@IBDesignable
class ScreenSizeAdjustingConstraintTests: NSLayoutConstraint {

    // MARK: - Properties
    @IBInspectable var adjustsToHeight: Bool = false
    @IBInspectable var adjustsToWidth: Bool = false
    @IBInspectable var ratio: CGFloat = 0.0

    // MARK: - Initializers
    override init() {
        super.init()
        commonInit()
    }

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    // MARK: - Functions
    private func commonInit() {
        adjust()
    }

    private func adjust() {
        if ratio != 0.0 {
            self.constant = ratio * (adjustsToHeight ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.width)
        }
    }

}

