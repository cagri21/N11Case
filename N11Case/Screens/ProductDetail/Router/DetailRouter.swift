//
//  DetailRouter.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 18.11.2024.
//
import NetworkProvider
import UIKit

// MARK: - DetailRouter
protocol DetailRouterProtocol: AnyObject {
    static func createModule(with product: ProductDisplayable) -> UIViewController
}

final class DetailRouter: DetailRouterProtocol {

    static func createModule(with product: ProductDisplayable) -> UIViewController {
//        let interactor = DetailInteractor(product: product)
        let router = DetailRouter()
        let viewController = ProductDetailViewController()
//        let presenter = DetailPresenter(view: viewController, interactor: interactor, router: router)
//        viewController.presenter = presenter
//        interactor.presenter = presenter
        return viewController
    }
}
