//
//  NSObject+Ext.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 19.11.2024.
//

import UIKit

extension NSObject {
    /// Returns the class name as a string
    var className: String {
        let className: String = String(describing: type(of: self))
        return className
    }
}
