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
        let interactor: ProductDetailInteractor = ProductDetailInteractor(apiService: ProductsService())
        let router: ProductDetailRouter = self
        let viewController: ProductDetailViewController = ProductDetailViewController()
        let entity: ProductDetailEntity = ProductDetailEntity(product: product)
        let presenter: ProductDetailPresenter = ProductDetailPresenter(view: viewController, interactor: interactor, router: router, entity: entity)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}
