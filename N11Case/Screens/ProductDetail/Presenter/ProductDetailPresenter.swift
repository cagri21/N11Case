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
    private let interactor: any ProductDetailInteractorProtocol
    private let router: ProductDetailRouterProtocol

    private var isLoading: Bool = false {
        didSet {
            view?.showLoading(isLoading)
        }
    }

    init(view: ProductDetailViewProtocol, interactor: any ProductDetailInteractorProtocol, router: ProductDetailRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        isLoading = true
        interactor.fetchProduct()
    }

}
// swiftlint:disable no_grouping_extension
extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    func didFetchData() {
        isLoading = false
        view?.showData()
    }

    func didFailToFetchData(_ errorMessage: String) {
        isLoading = false
        view?.showError(errorMessage)
    }

}
// swiftlint:enable no_grouping_extension
