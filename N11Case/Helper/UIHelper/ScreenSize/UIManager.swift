//
//  UIManager.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import UIKit

public struct UIManager {

    public static func width() -> CGFloat {
        let width: CGFloat = UIScreen.main.bounds.width
        return width
    }

    public static func height() -> CGFloat {
        let height: CGFloat = UIScreen.main.bounds.height
        return height
    }

}
