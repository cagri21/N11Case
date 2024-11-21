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
    private let interactor: ProductsInteractorProtocol
    private let router: ProductsRouterProtocol
    private var entity: ProductsEntity

    private var isLoading: Bool = false {
        didSet {
            view?.showLoading(isLoading)
        }
    }

    init(view: ProductsViewProtocol, interactor: ProductsInteractorProtocol, router: ProductsRouterProtocol, entity: ProductsEntity) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.entity = entity
    }

    func viewDidLoad() {
        isLoading = true
        interactor.fetchProducts(page: entity.pagination.currentPage)
    }

    func fetchNextPage() {
        guard !isLoading, entity.pagination.hasNextPage else {
            return
        }
        isLoading = true
        interactor.fetchProducts(page: entity.pagination.currentPage)
    }

    func numberOfSections() -> Int {
        let sectionsCount: Int = entity.sections.count
        return sectionsCount
    }

    func numberOfItems(in section: Int) -> Int {
        switch entity.sections[section] {
        case .sponsored(let products):
            return products.count
        case .products(let products):
            return products.count
        }
    }

    func sectionType(at section: Int) -> SectionType {
        let sectionType: SectionType = entity.sections[section]
        return sectionType
    }

    func product(at indexPath: IndexPath) -> ProductDisplayable {
        switch entity.sections[indexPath.section] {
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
    func didFetchData(_ response: ProductsResponse) {
        if response.nextPage != nil {
            entity.pagination.nextPage()
        } else {
            entity.pagination.hasNextPage = false
        }

        if let sponsored = response.sponsoredProducts, !sponsored.isEmpty {
            entity.sections.append(.sponsored(sponsored))
        }
        entity.sections.append(.products(response.products))

        isLoading = false
        view?.showData()
    }

    func didFailToFetchData(_ error: any Error) {
        isLoading = false
        view?.showError("Failed to load products")
    }
}
// swiftlint:enable no_grouping_extension
