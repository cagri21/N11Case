//
//  BaseVC.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import XCTest
@testable import N11Case

final class BaseViewControllerTests: XCTestCase {

    var baseViewController: BaseViewController!

    override func setUp() {
        super.setUp()
        baseViewController = BaseViewController()
    }

    override func tearDown() {
        baseViewController = nil
        super.tearDown()
    }

    /// Test if `setupUI()` is called during `viewDidLoad`
    func testSetupUICalledInViewDidLoad() {
        let mockBaseViewController = MockBaseViewController()

        _ = mockBaseViewController.view // Trigger `viewDidLoad`

        XCTAssertTrue(mockBaseViewController.setupUICalled, "setupUI() should be called in viewDidLoad.")
    }
}

// MARK: - Mock Classes

/// Mock BaseViewController to test `setupUI` behavior
final class MockBaseViewController: BaseViewController {

    var setupUICalled = false

    override func setupUI() {
        setupUICalled = true
    }
}

/// Mock Logger
var DLog: (String) -> Void = { _ in }
