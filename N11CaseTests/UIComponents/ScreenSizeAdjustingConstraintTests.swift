//
//  Untitled.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 19.11.2024.
//


@testable import N11Case
import Testing
class ScreenSizeAdjustingConstraintTests: XCTestCase {

    var screenSizeInstance: ScreenSizeAdjustingConstraint!

    override func setUp() {
        super.setUp()

        screenSizeInstance = ScreenSizeAdjustingConstraint()
        screenSizeInstance.adjustsToHeight = true
        screenSizeInstance.ratio = 0.2
    }

    override func tearDown() {
        super.tearDown()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
         self.screenSizeInstance = nil
    }

    func testConstraintHasBeenInstantiated() {
        XCTAssertNotNil(screenSizeInstance)
    }

    func testConstraintIsArrangedProperly() {
        XCTAssertEqual(screenSizeInstance.adjustsToHeight, true)
        XCTAssertEqual(screenSizeInstance.adjustsToWidth, false)
        XCTAssertEqual(screenSizeInstance.ratio, 0.2)
    }

}

