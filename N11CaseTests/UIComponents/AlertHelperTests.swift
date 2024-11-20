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
        // Arrange
        let expectedTitle = NSLocalizedString("Attention", comment: "Alert Info Title")

        // Act
        let actualTitle = Alert.attentionTitle

        // Assert
        XCTAssertEqual(actualTitle, expectedTitle, "Alert.attentionTitle should return the correct localized string.")
    }

    /// Test to verify the localization of the info title
    func testInfoTitleLocalization() {
        // Arrange
        let expectedTitle = NSLocalizedString("Info", comment: "Alert Info Title")

        // Act
        let actualTitle = Alert.infoTitle

        // Assert
        XCTAssertEqual(actualTitle, expectedTitle, "Alert.infoTitle should return the correct localized string.")
    }

    /// Test to verify the localization of the error title
    func testErrorTitleLocalization() {
        // Arrange
        let expectedTitle = NSLocalizedString("Error", comment: "Alert Error Title")

        // Act
        let actualTitle = Alert.errorTitle

        // Assert
        XCTAssertEqual(actualTitle, expectedTitle, "Alert.errorTitle should return the correct localized string.")
    }

    /// Test for fallbacks when localization keys are missing
    func testMissingLocalizationFallback() {
        // Arrange
        setLocale("es") // Assume "es" localization is missing for demonstration
        let defaultAttention = "Attention"
        let defaultInfo = "Info"
        let defaultError = "Error"

        // Act
        let attentionTitle = Alert.attentionTitle
        let infoTitle = Alert.infoTitle
        let errorTitle = Alert.errorTitle

        // Assert
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
