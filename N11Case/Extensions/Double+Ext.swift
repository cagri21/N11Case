//
//  Double+Ext.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 19.11.2024.
//

import UIKit

extension Double {
    func toString() -> String {
        let stringValue: String = String(format: "%.1f", self)
        return stringValue
    }
}
