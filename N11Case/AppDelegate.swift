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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)

        createNetworkLogger(application)

        window?.makeKeyAndVisible()
        window?.rootViewController = createProductModule()

        return true
    }

    // MARK: UISceneSession Lifecycle
    func applicationWillResignActive(_ application: UIApplication) {
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        application.applicationSupportsShakeToEdit = false
        NFX.sharedInstance().start()
        NFX.sharedInstance().setGesture(.custom)
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func createProductModule() -> UINavigationController {
        let productListModule: UIViewController = ProductsRouter.createModule()
        let navigationController: UINavigationController = UINavigationController(rootViewController: productListModule)
        return navigationController
    }

    private func createNetworkLogger(_ application: UIApplication) {
        application.applicationSupportsShakeToEdit = true
        NFX.sharedInstance().start()
        NFX.sharedInstance().setGesture(.custom)
    }

}
