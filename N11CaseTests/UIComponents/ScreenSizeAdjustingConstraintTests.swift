//
//  ScreenSizeAdjustingConstraintTests.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 19.11.2024.
//

@testable import N11Case
import XCTest

class ScreenSizeAdjustingConstraintTests: XCTestCase {

    var screenSizeInstance: ScreenSizeAdjustingConstraint!

    override func setUpWithError() throws {
        try super.setUpWithError()

        // Initialize the instance with default values
        screenSizeInstance = ScreenSizeAdjustingConstraint()
        screenSizeInstance.adjustsToHeight = true
        screenSizeInstance.ratio = 0.2
    }

    override func tearDownWithError() throws {
        screenSizeInstance = nil
        try super.tearDownWithError()
    }

    func testConstraintHasBeenInstantiated() {
        XCTAssertNotNil(screenSizeInstance, "The screenSizeInstance should not be nil after initialization.")
    }

    func testConstraintIsArrangedProperly() {
        XCTAssertEqual(screenSizeInstance.adjustsToHeight, true, "The adjustsToHeight property should be true.")
        XCTAssertEqual(screenSizeInstance.adjustsToWidth, false, "The adjustsToWidth property should be false.")
        XCTAssertEqual(screenSizeInstance.ratio, 0.2, "The ratio should be 0.2.")
    }

    func testAdjustsToWidth() {
        // Modify adjustsToWidth and test
        screenSizeInstance.adjustsToWidth = true
        screenSizeInstance.adjustsToHeight = false

        XCTAssertTrue(screenSizeInstance.adjustsToWidth, "The adjustsToWidth property should be true.")
        XCTAssertFalse(screenSizeInstance.adjustsToHeight, "The adjustsToHeight property should now be false.")
    }

    func testConstraintRatioChanges() {
        // Modify the ratio and test
        screenSizeInstance.ratio = 0.5
        XCTAssertEqual(screenSizeInstance.ratio, 0.5, "The ratio should now be updated to 0.5.")
    }
}
