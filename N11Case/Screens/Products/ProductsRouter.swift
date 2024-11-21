//
//  ProductRouter.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 16.11.2024.
//

import NetworkProvider
import UIKit

protocol ProductsRouterProtocol: BaseRouterProtocol {
    func navigateToDetail(from view: Viewable, with entity: ProductDisplayable)
}

final class ProductsRouter: ProductsRouterProtocol {

    init() {
    }

    func navigateToDetail(from view: Viewable, with entity: ProductDisplayable) {
        let apiService: ProductsService = ProductsService()
        let detailViewController: UIViewController = ProductDetailRouter().createModule(with: entity, apiService: apiService)
        view.push(detailViewController, animated: true)
    }

    func createModule() -> UIViewController {
        let apiService: ProductsService = ProductsService()
        let productsEntity: ProductsEntity = ProductsEntity()
        let errorService: ErrorHandlingServiceProtocol = ErrorHandlingService()
        let interactor: ProductsInteractor = ProductsInteractor(apiService: apiService, entity: productsEntity, errorHandlingService: errorService)
        let router: ProductsRouter = self
        let viewController: ProductsViewController = ProductsViewController()
        let presenter: ProductsPresenter = ProductsPresenter(
            view: viewController,
            interactor: interactor,
            router: router
        )
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}
