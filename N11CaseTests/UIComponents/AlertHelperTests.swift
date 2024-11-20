//
//  AlertHelperTests.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import XCTest
@testable import N11Case

class AlertHelperTests: XCTestCase {

    /// Test to verify the localization of the attention title
    func testAttentionTitleLocalization() {
        let expectedTitle = NSLocalizedString("Attention", comment: "Alert Info Title")

        let actualTitle = Alert.attentionTitle

        XCTAssertEqual(actualTitle, expectedTitle, "Alert.attentionTitle should return the correct localized string.")
    }

    /// Test to verify the localization of the info title
    func testInfoTitleLocalization() {
        let expectedTitle = NSLocalizedString("Info", comment: "Alert Info Title")

        let actualTitle = Alert.infoTitle

        XCTAssertEqual(actualTitle, expectedTitle, "Alert.infoTitle should return the correct localized string.")
    }

    /// Test to verify the localization of the error title
    func testErrorTitleLocalization() {
        let expectedTitle = NSLocalizedString("Error", comment: "Alert Error Title")

        let actualTitle = Alert.errorTitle

        XCTAssertEqual(actualTitle, expectedTitle, "Alert.errorTitle should return the correct localized string.")
    }

    /// Test for fallbacks when localization keys are missing
    func testMissingLocalizationFallback() {
        setLocale("es") // Assume "es" localization is missing for demonstration
        let defaultAttention = "Attention"
        let defaultInfo = "Info"
        let defaultError = "Error"

        let attentionTitle = Alert.attentionTitle
        let infoTitle = Alert.infoTitle
        let errorTitle = Alert.errorTitle

        XCTAssertEqual(attentionTitle, defaultAttention, "Fallback for Attention failed.")
        XCTAssertEqual(infoTitle, defaultInfo, "Fallback for Info failed.")
        XCTAssertEqual(errorTitle, defaultError, "Fallback for Error failed.")
    }

    // Helper to switch locale
    private func setLocale(_ locale: String) {
        UserDefaults.standard.set([locale], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}
