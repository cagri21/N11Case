//
//  String+Ext.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import Foundation

// MARK: - Generic Button Labels

public struct ButtonLabel {
    public static let ok: String = NSLocalizedString("OK", comment: "Button Label")
    public static let cancel: String = NSLocalizedString("Cancel", comment: "Button Label")
    public static let yes: String = NSLocalizedString("Yes", comment: "Button Label")
    public static let no: String = NSLocalizedString("No", comment: "Button Label")
}

// MARK: - Title Strings

public struct Alert {
    public static let attentionTitle: String = NSLocalizedString("Attention", comment: "Alert Info Title")
    public static let infoTitle: String = NSLocalizedString("Info", comment: "Alert Info Title")
    public static let errorTitle: String = NSLocalizedString("Error", comment: "Alert Error Title")
}
