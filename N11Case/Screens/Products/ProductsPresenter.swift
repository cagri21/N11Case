//
//  ProductPresenter.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 16.11.2024.
//

import Foundation
import NetworkProvider

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
        interactor.fetchProducts(page: interactor.entity.pagination.currentPage)
    }

    func fetchNextPage() {
        guard !isLoading, interactor.entity.pagination.hasNextPage else {
            return
        }
        isLoading = true
        interactor.fetchProducts(page: interactor.entity.pagination.currentPage)
    }

    func numberOfSections() -> Int {
        let sectionsCount: Int = interactor.entity.sections.count
        return sectionsCount
    }

    func numberOfItems(in section: Int) -> Int {
        switch interactor.entity.sections[section] {
        case .sponsored(let products):
            return products.count
        case .products(let products):
            return products.count
        }
    }

    func sectionType(at section: Int) -> SectionType {
        let sectionType: SectionType = interactor.entity.sections[section]
        return sectionType
    }

    func product(at indexPath: IndexPath) -> ProductDisplayable {
        switch interactor.entity.sections[indexPath.section] {
        case .sponsored(let products):
            return products[indexPath.item]
        case .products(let products):
            return products[indexPath.item]
        }
    }

    func didSelectProduct(_ product: ProductDisplayable) {
        guard let view = view as? BaseViewController else {
            Logger.debug("View couldn't find at presenter in didSelectProduct.")
            return
        }

        router.navigateToDetail(from: view, with: product)
    }

}
// swiftlint:disable no_grouping_extension
extension ProductsPresenter: ProductsInteractorOutputProtocol {
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
