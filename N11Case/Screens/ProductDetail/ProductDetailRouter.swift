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
    func createModule(with product: ProductDisplayable, apiService: ProductsServiceProtocol) -> UIViewController
}

final class ProductDetailRouter: ProductDetailRouterProtocol {

    init() { }

    func createModule(with product: ProductDisplayable, apiService: ProductsServiceProtocol) -> UIViewController {
        let errorService: ErrorHandlingServiceProtocol = ErrorHandlingService()
        let productEntity: ProductDetailEntity = ProductDetailEntity(product: product)
        let interactor: ProductDetailInteractor = ProductDetailInteractor(apiService: ProductsService(), entity: productEntity, errorHandlingService: errorService)
        let router: ProductDetailRouter = self
        let viewController: ProductDetailViewController = ProductDetailViewController()
        let presenter: ProductDetailPresenter = ProductDetailPresenter(view: viewController, interactor: interactor, router: router)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}
