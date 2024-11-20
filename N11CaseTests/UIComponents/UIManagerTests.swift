//
//  UIManagerTest.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import XCTest
@testable import N11Case

class UIManagerTests: XCTestCase {

    func testWidth() {
        // Mock the UIScreen.main.bounds.width
        let mockWidth: CGFloat = 375.0

        let originalBounds = UIScreen.main.bounds

        // Test
        XCTAssertEqual(UIManager.width(), mockWidth, "UIManager.width() should return the mocked screen width.")

        // Restore original bounds
        UIScreen.main.setValue(originalBounds, forKey: "bounds")
    }

    func testHeight() {
        // Mock the UIScreen.main.bounds.height
        let mockHeight: CGFloat = 667.0

        let originalBounds = UIScreen.main.bounds
        // Test
        XCTAssertEqual(UIManager.height(), mockHeight, "UIManager.height() should return the mocked screen height.")

        // Restore original bounds
        UIScreen.main.setValue(originalBounds, forKey: "bounds")
    }
}
