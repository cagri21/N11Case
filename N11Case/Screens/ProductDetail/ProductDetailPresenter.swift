//
//  ProductDetailPresenter.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import NetworkProvider
import UIKit

protocol ProductDetailPresenterProtocol: BasePresenterProtocol {
    func numberOfSections() -> Int
    func numberOfItems() -> Int
    func productImage(at indexPath: IndexPath) -> String
    func getProduct() -> (title: String, description: String, price: Double, discountedPrice: Double?, rate: Double?, sellerName: String)
}

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

    func numberOfSections() -> Int {
        let sectionCount: Int = 1
        return sectionCount
    }

    func numberOfItems() -> Int {
        guard let imagesCount: Int = interactor.entity.productDetail?.images.count else {
            return 0
        }
        return imagesCount
    }

    func productImage(at indexPath: IndexPath) -> String {
        guard let image: String = interactor.entity.productDetail?.images[indexPath.item] else {
            return ""
        }
        return image
    }

    func getProduct() -> (title: String, description: String, price: Double, discountedPrice: Double?, rate: Double?, sellerName: String) {
        guard let product = interactor.entity.productDetail else {
            return (title: "", description: "", price: 0, discountedPrice: nil, rate: nil, sellerName: "")
        }
        // Extract the values from the ProductResponse object and return as a tuple
        return (title: product.title, description: product.description, price: product.price, discountedPrice: product.instantDiscountPrice, rate: product.rate, sellerName: product.sellerName)
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
