//
//  AlertHelper.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import UIKit

struct SingleActionAlertConfig {
    let title: String
    let message: String
    let actionLabel: String?
    let actionHandler: ((UIAlertAction) -> Void)?
    let completion: (() -> Void)?
}

struct MultiActionAlertConfig {
    let title: String
    let message: String
    let actionLabel: String?
    let actionHandler: ((UIAlertAction) -> Void)?
    let cancelHandler: ((UIAlertAction) -> Void)?
    let completion: (() -> Void)?
}

protocol AlertPresentable {
    func presentAlert(message: String, handler: ((UIAlertAction) -> Void)?)
    func presentAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?)
    func presentAlert(viewController: UIViewController, title: String, message: String, handler: ((UIAlertAction) -> Void)?, completion: (() -> Void)?)
    func presentAlertWithSingleAction(viewController: UIViewController, config: SingleActionAlertConfig)
    func presentAlertWithAction(viewController: UIViewController, config: MultiActionAlertConfig)
}

struct AlertPresenter: AlertPresentable {

    func presentAlert(message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        if let viewController = UIApplication.shared.getTopViewController() {
            presentAlert(viewController: viewController, title: Alert.infoTitle, message: message, handler: handler, completion: nil)
        }
    }

    func presentAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        if let viewController = UIApplication.shared.getTopViewController() {
            presentAlert(viewController: viewController, title: title, message: message, handler: handler, completion: nil)
        }
    }

    func presentAlert(viewController: UIViewController, title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil, completion: (() -> Void)? = nil) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: ButtonLabel.ok, style: .default, handler: handler)
        alert.addAction(defaultAction)
        viewController.present(alert, animated: true, completion: completion)
    }

    func presentAlertWithSingleAction(viewController: UIViewController, config: SingleActionAlertConfig) {
        let alert: UIAlertController = UIAlertController(title: config.title, message: config.message, preferredStyle: .alert)
        let primaryAction: UIAlertAction = UIAlertAction(title: config.actionLabel, style: .default, handler: config.actionHandler)
        alert.addAction(primaryAction)
        viewController.present(alert, animated: true, completion: config.completion)
    }

    func presentAlertWithAction(viewController: UIViewController, config: MultiActionAlertConfig) {
        let alert: UIAlertController = UIAlertController(title: config.title, message: config.message, preferredStyle: .alert)
        if let actionLabel = config.actionLabel {
            let primaryAction: UIAlertAction = UIAlertAction(title: actionLabel, style: .default, handler: config.actionHandler)
            alert.addAction(primaryAction)
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: ButtonLabel.cancel, style: .cancel, handler: config.cancelHandler)
        alert.addAction(cancelAction)
        viewController.present(alert, animated: true, completion: config.completion)
    }
}
