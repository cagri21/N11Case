//
//  DetailRouter.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 18.11.2024.
//
import NetworkProvider
import UIKit

// MARK: - DetailRouter
protocol ProductDetailRouterProtocol: AnyObject {
    static func createModule(with product: ProductDisplayable) -> UIViewController
}

final class ProductDetailRouter: ProductDetailRouterProtocol {

    static func createModule(with product: ProductDisplayable) -> UIViewController {
        let interactor = ProductDetailInteractor(apiService: ProductsService())
        let router: ProductDetailRouter = ProductDetailRouter()
        let viewController: ProductDetailViewController = ProductDetailViewController(presenter: nil)
        let presenter = ProductDetailPresenter(view: viewController, interactor: interactor, router: router)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}
