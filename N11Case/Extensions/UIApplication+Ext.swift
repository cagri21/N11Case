//
//  UIApplication+Ext.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import UIKit

extension UIApplication {
    func topViewControllerPresentedModally(controller: UIViewController? = {
            // Access the first UIWindowScene and get its key window's rootViewController
            if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene {
                return windowScene.windows.first { $0.isKeyWindow }?.rootViewController
            }
            return nil
        }()) -> UIViewController? {
            if let presented: UIViewController = controller?.presentedViewController {
                return topViewControllerPresentedModally(controller: presented)
            }
            return controller
        }
    func getTopViewController(controller: UIViewController? = {
            // Access the first UIWindowScene and get its windows
            if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene {
                return windowScene.windows.first { $0.isKeyWindow }?.rootViewController
            }
            return nil
        }()) -> UIViewController? {
            if let nav = controller as? UINavigationController {
                return getTopViewController(controller: nav.visibleViewController)
            } else if let tab = controller as? UITabBarController,
                      let selected = tab.selectedViewController {
                return getTopViewController(controller: selected)
            } else if let presented = controller?.presentedViewController {
                return getTopViewController(controller: presented)
            }
            return controller
        }
}
