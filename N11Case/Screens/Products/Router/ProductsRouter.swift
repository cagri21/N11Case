//
//  ProductRouter.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 16.11.2024.
//

import NetworkProvider
import UIKit

protocol ProductsRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToDetail(from view: BaseViewController, with product:ProductDisplayable)
}

final class ProductsRouter: ProductsRouterProtocol {

    static func createModule() -> UIViewController {
        let apiService: ProductsService = ProductsService()
        let interactor: ProductsInteractor = ProductsInteractor(apiService: apiService)
        let router: ProductsRouter = ProductsRouter()
        let viewController: ProductsViewController = ProductsViewController(presenter: nil)
        let presenter: ProductsPresenter = ProductsPresenter(view: viewController, interactor: interactor, router: router)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
    
    func navigateToDetail(from view: BaseViewController, with product: ProductDisplayable) {
        let detailViewController = DetailRouter.createModule(with: product)
        view.navigationController?.pushViewController(detailViewController, animated: true)
    }

}
