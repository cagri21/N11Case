//
//  ProductDetailPresenter.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import NetworkProvider

protocol ProductDetailPresenterProtocol: BasePresenterProtocol { }

final class ProductDetailPresenter: ProductDetailPresenterProtocol {

    private weak var view: ProductDetailViewProtocol?
    private let interactor: ProductDetailInteractorProtocol
    private let router: ProductDetailRouterProtocol
    private var entity: ProductDetailEntity

    private var isLoading: Bool = false {
        didSet {
            view?.showLoading(isLoading)
        }
    }

    init(view: ProductDetailViewProtocol, interactor: ProductDetailInteractorProtocol, router: ProductDetailRouterProtocol, entity: ProductDetailEntity) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.entity = entity
    }

    func viewDidLoad() {
        isLoading = true
        interactor.fetchProduct()
    }

}
// swiftlint:disable no_grouping_extension
extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    func didFetchData(_ response: ProductResponse) {
        isLoading = false
        view?.showData()
    }

    func didFailToFetchData(_ errorMessage: String) {
        isLoading = false
        view?.showError(errorMessage)
    }

}
// swiftlint:enable no_grouping_extension
