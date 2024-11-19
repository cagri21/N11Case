//
//  UIView+Ext.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import UIKit

extension UIView {
    func animateFade(duration: TimeInterval = 0.2, fadeTo alphaValue: CGFloat = 0.5, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration / 2, animations: {
            self.alpha = alphaValue // Fade out
        }) { _ in
            UIView.animate(withDuration: duration / 2, animations: {
                self.alpha = 1.0 // Fade back in
            }, completion: { _ in
                completion?()
            })
        }
    }
}
