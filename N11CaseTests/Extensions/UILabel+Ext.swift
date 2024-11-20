//
//  UILabelExtTests.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//
import XCTest
@testable import N11Case

final class UILabelExtTests: XCTestCase {

    var label: UILabel!

    override func setUp() {
        super.setUp()
        label = UILabel()
    }

    override func tearDown() {
        label = nil
        super.tearDown()
    }

    /// Test applying a strikethrough when the label has no text
    func testApplyStrikethroughWithEmptyText() {
        label.text = ""
        label.strikeThrough(true)
        XCTAssertNil(label.attributedText, "Attributed text should remain nil when applying strikethrough to an empty label.")
    }
}
