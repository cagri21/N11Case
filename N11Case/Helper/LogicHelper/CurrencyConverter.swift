//
//  CurrencyFormatter.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 19.11.2024.
//

import Foundation

enum CurrencyFormatter {
    case turkey
    case usa
    case eurozone
    case uk
    case japan

    /// Returns the formatted price with the appropriate currency symbol or abbreviation.
    /// - Parameter price: The numeric price to format.
    /// - Returns: A string representation of the price with the currency appended.
    func format(price: Double) -> String {
        switch self {
        case .turkey:
            return "\(price) TL"
        case .usa:
            return "$\(price)"
        case .eurozone:
            return "€\(price)"
        case .uk:
            return "£\(price)"
        case .japan:
            return "¥\(price)"
        }
    }
}
