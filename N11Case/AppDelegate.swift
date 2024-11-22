//
//  AppDelegate.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import netfox
import NetworkProvider
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var navigationController: UINavigationController?
    var window: UIWindow?

    var isUnitTesting: Bool {
        ProcessInfo.processInfo.arguments.contains("-UNITTEST")
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)

        if !isUnitTesting {
            configureNavigationBarAppearance()
            startNetworkLogger(application)
        }

        window?.makeKeyAndVisible()
        window?.rootViewController = createProductModule()

        return true
    }

    // MARK: UISceneSession Lifecycle
    func applicationWillResignActive(_ application: UIApplication) {
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        stopNetworkLogger(application)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        stopNetworkLogger(application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        stopNetworkLogger(application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        startNetworkLogger(application)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        stopNetworkLogger(application)
    }

    private func createProductModule() -> UINavigationController {
        // Create an instance of ProductsRouter with the required dependency
        let productsRouter: ProductsRouter = ProductsRouter()

                // Use the router to create the initial Products module
        let productsViewController: UIViewController = productsRouter.createModule()
        let navigationController: UINavigationController = UINavigationController(rootViewController: productsViewController)
        return navigationController
    }

    private func startNetworkLogger (_ application: UIApplication) {
        #if DEBUG
        if !NFX.sharedInstance().isStarted() {
            application.applicationSupportsShakeToEdit = true
            NFX.sharedInstance().start()
            NFX.sharedInstance().setGesture(.custom)
        }
        #endif
    }

    private func stopNetworkLogger(_ application: UIApplication) {
        #if DEBUG
        application.applicationSupportsShakeToEdit = false
        NFX.sharedInstance().stop()
        #endif
    }

    private func configureNavigationBarAppearance() {
        // Set the background color
        UINavigationBar.appearance().barTintColor = UIColor.ProductBackgroundColor

        // Set the tint color for bar button items
        UINavigationBar.appearance().tintColor = UIColor.white

            // Set the title text attributes
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]

        // For iOS 15+, configure the appearance directly
        if #available(iOS 15.0, *) {
            let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.ProductBackgroundColor
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 18, weight: .bold)
            ]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
