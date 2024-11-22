//
//  SectionPagerViewTests.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//
import UIKit

import XCTest
@testable import N11Case

class SectionPagerViewTests: XCTestCase {

    /// Test the initialization of SectionPagerView
    func testInitialization() {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 50)

        let pagerView = SectionPagerView(frame: frame)

        XCTAssertNotNil(pagerView, "SectionPagerView should initialize successfully.")
        XCTAssertEqual(pagerView.subviews.count, 1, "SectionPagerView should have one subview: the page control.")
        XCTAssertTrue(pagerView.subviews.first is UIPageControl, "The subview should be a UIPageControl.")
    }

    /// Test the configuration of the page control
    func testConfigurePageControl() {
        let pagerView = SectionPagerView(frame: .zero)

        pagerView.configure(with: 5, currentPage: 2)
        let configuration = pagerView.getCurrentConfiguration()

        XCTAssertEqual(configuration.numberOfPages, 5, "Page control should be configured with 5 pages.")
        XCTAssertEqual(configuration.currentPage, 2, "Page control should be configured with the current page as 2.")
    }

    /// Test that the default configuration of the page control is correct
    func testDefaultConfiguration() {
        let pagerView = SectionPagerView(frame: .zero)

        let configuration = pagerView.getCurrentConfiguration()

        XCTAssertEqual(configuration.numberOfPages, 0, "Default number of pages should be 0.")
        XCTAssertEqual(configuration.currentPage, 0, "Default current page should be 0.")
    }

    /// Test layout constraints for page control
    func testPageControlLayoutConstraints() {
        let pagerView = SectionPagerView(frame: .zero)
        pagerView.layoutIfNeeded()

        let constraints = pagerView.constraints.filter {
            $0.firstItem === pagerView.subviews.first || $0.secondItem === pagerView.subviews.first
        }

        XCTAssertEqual(constraints.count, 2, "There should be two constraints applied to the page control.")
        XCTAssertTrue(constraints.contains { $0.firstAttribute == .centerX }, "Page should be horizontally centered.")
        XCTAssertTrue(constraints.contains { $0.firstAttribute == .centerY }, "Page should be vertically centered.")
    }
}
