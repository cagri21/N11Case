//
//  ProductPresenter.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 16.11.2024.
//

import Foundation
import NetworkProvider
import UIKit

protocol ProductsPresenterProtocol: BasePresenterProtocol {
    func fetchNextPage()
    func numberOfSections() -> Int
    func sectionType(at index: Int) -> SectionType
    func numberOfItems(in section: Int) -> Int
    func product(at indexPath: IndexPath) -> ProductDisplayable
    func didSelectProduct(_ product: ProductDisplayable)
}

final class ProductsPresenter: ProductsPresenterProtocol {

    private weak var view: ProductsViewProtocol?
    private let interactor: any ProductsInteractorProtocol
    private let router: ProductsRouterProtocol

    private var isLoading: Bool = false {
        didSet {
            view?.showLoading(isLoading)
        }
    }

    init(view: ProductsViewProtocol, interactor: any ProductsInteractorProtocol, router: ProductsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        isLoading = true
        interactor.fetchProducts(page: interactor.getEntity().pagination.currentPage)
    }

    func fetchNextPage() {
        guard !isLoading, interactor.getEntity().pagination.hasNextPage else {
            return
        }
        isLoading = true
        interactor.fetchProducts(page: interactor.getEntity().pagination.currentPage)
    }

    func numberOfSections() -> Int {
        let sectionsCount: Int = interactor.getEntity().sections.count
        return sectionsCount
    }

    func numberOfItems(in section: Int) -> Int {
        switch interactor.getEntity().sections[section] {
        case .sponsored(let products):
            return products.count
        case .products(let products):
            return products.count
        }
    }

    func sectionType(at section: Int) -> SectionType {
        let sectionType: SectionType = interactor.getEntity().sections[section]
        return sectionType
    }

    func product(at indexPath: IndexPath) -> ProductDisplayable {
        switch interactor.getEntity().sections[indexPath.section] {
        case .sponsored(let products):
            return products[indexPath.item]
        case .products(let products):
            return products[indexPath.item]
        }
    }

    func didSelectProduct(_ product: ProductDisplayable) {
        guard let view = view as? BaseViewController else {
            DLog("\(ProductsPresenter.self): View couldn't find at presenter in didSelectProduct.")
            return
        }

        router.navigateToDetail(from: view, with: product)
    }

}
// swiftlint:disable no_grouping_extension
extension ProductsPresenter: ProductsInteractorOutputProtocol {
    func didFetchData(_ response: ProductsEntity) {
        isLoading = false
        view?.showData()
    }

    func didFailToFetchData(_ error: any Error) {
        isLoading = false
        view?.showError("Failed to load products")
    }
}
// swiftlint:enable no_grouping_extension
