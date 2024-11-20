//
//  UIApplication+Ext.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import XCTest
@testable import N11Case

class UIApplicationExtensionsTests: XCTestCase {

    /// Mock UIWindow for testing purposes
    class MockWindow: UIWindow {
        override var isKeyWindow: Bool { return true }
    }

    /// Test `getTopViewController` for a UINavigationController hierarchy
    func testGetTopViewControllerWithNavigationController() {
        // Arrange
        let rootViewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        let pushedViewController = UIViewController()
        navigationController.pushViewController(pushedViewController, animated: false)

        // Use a mock window and set it as the key window
        let mockWindow = MockWindow()
        mockWindow.rootViewController = navigationController
        mockWindow.makeKeyAndVisible()

        // Act
        let topViewController = UIApplication.shared.getTopViewController()

        // Assert
        XCTAssertEqual(topViewController, pushedViewController, "The top view controller should navigation stack.")
    }
    /// Test `getTopViewController` for a UITabBarController hierarchy
    func testGetTopViewControllerWithTabBarController() {
        // Arrange
        let firstViewController = UIViewController()
        let secondViewController = UIViewController()
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstViewController, secondViewController]
        tabBarController.selectedIndex = 1

        // Create a mock window and set it as the key window
        let mockWindow = MockWindow()
        mockWindow.rootViewController = tabBarController
        mockWindow.makeKeyAndVisible()

        // Simulate adding the mock window to the first UIWindowScene
        let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0 is UIWindowScene }) as? UIWindowScene

        XCTAssertNotNil(windowScene, "UIWindowScene should be available for testing.")

        // Inject the mock window into the UIWindowScene
        windowScene?.windows.forEach { $0.isHidden = true } // Hide all existing windows
        windowScene?.value(forKey: "windows").map { windows in
            (windows as? NSMutableArray)?.add(mockWindow) // Add the mock window to the scene's windows
        }

        // Act
        let topViewController = UIApplication.shared.getTopViewController()

        // Assert
        XCTAssertEqual(topViewController, secondViewController, "The top view controller should view  of the tab bar.")
    }

    /// Test `getTopViewController` for combined hierarchy (UINavigationController + UITabBarController)
    func testGetTopViewControllerWithCombinedHierarchy() {
        // Arrange
        let tabBarController = UITabBarController()
        let navigationController = UINavigationController(rootViewController: UIViewController())
        tabBarController.viewControllers = [navigationController]
        tabBarController.selectedIndex = 0

        // Create a mock window and set it as the key window
        let mockWindow = MockWindow()
        mockWindow.rootViewController = tabBarController
        mockWindow.makeKeyAndVisible()

        // Inject the mock window into the UIWindowScene
        let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0 is UIWindowScene }) as? UIWindowScene

        XCTAssertNotNil(windowScene, "UIWindowScene should be available for testing.")

        // Hide all existing windows and inject the mock window
        windowScene?.windows.forEach { $0.isHidden = true } // Hide all other windows
        windowScene?.value(forKey: "windows").map { windows in
            (windows as? NSMutableArray)?.add(mockWindow) // Add the mock window to the scene's windows
        }

        // Act
        let topViewController = UIApplication.shared.getTopViewController()

        // Assert
        XCTAssertEqual(topViewController, navigationController.visibleViewController, "")
    }

    /// Test `getTopViewController` with no window or rootViewController
    func testGetTopViewControllerWithNoWindowOrRootViewController() {
        // Arrange
        // Simulate a situation where there are no windows in any active UIWindowScene
        let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0 is UIWindowScene }) as? UIWindowScene

        XCTAssertNotNil(windowScene, "UIWindowScene should be available for testing.")

        // Hide all windows in the scene
        windowScene?.windows.forEach { $0.isHidden = true }

        // Act
        let topViewController = UIApplication.shared.getTopViewController()

        // Assert
        XCTAssertNil(topViewController, "")
    }
}
