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

    private let apiService: ProductsServiceProtocol

    init(apiService: ProductsServiceProtocol) {
        self.apiService = apiService
    }

    func navigateToDetail(from view: Viewable, with entity: ProductDisplayable) {
        let detailViewController: UIViewController = ProductDetailRouter().createModule(with: entity, apiService: apiService)
        view.push(detailViewController, animated: true)
    }

    func createModule() -> UIViewController {
        let productsEntity: ProductsEntity = ProductsEntity()
        let interactor: ProductsInteractor = ProductsInteractor(apiService: apiService, entity: productsEntity)
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
