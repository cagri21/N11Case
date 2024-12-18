//
//  UIWindow+Ext.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 17.11.2024.
//

import netfox
import NetworkProvider
import UIKit

extension UIWindow {
    open override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionBegan(motion, with: event)

        guard motion == UIEvent.EventSubtype.motionShake else {
            Logger.error("Unable to find UIEvent.EventSubtype.motionShak")
            return
        }

        if motion == .motionShake {
            #if DEBUG
                NFX.sharedInstance().show()
            #endif
        }
    }
}
