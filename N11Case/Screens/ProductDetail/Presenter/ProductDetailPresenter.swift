//
//  ProductDetailPresenter.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import NetworkProvider

protocol ProductDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class ProductDetailPresenter: ProductDetailPresenterProtocol {

    private weak var view: ProductDetailViewProtocol?
    private let interactor: ProductDetailInteractorProtocol
    private let router: ProductDetailRouterProtocol

    private var isLoading: Bool = false {
        didSet {
            view?.showLoading(isLoading)
        }
    }

    init(view: ProductDetailViewProtocol, interactor: ProductDetailInteractorProtocol, router: ProductDetailRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        isLoading = true
//        interactor.fetchProducts(page: currentPage)
    }

}
// swiftlint:disable no_grouping_extension
extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    func didFetchProduct(_ response: any NetworkProvider.ProductDisplayable) {
        isLoading = false
        view?.showProducts()
    }

    func didFailToFetchProducts(_ error: Error) {
        isLoading = false
        view?.showError("Failed to load products")
    }

}
// swiftlint:enable no_grouping_extension
