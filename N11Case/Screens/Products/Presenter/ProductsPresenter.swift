//
//  ProductPresenter.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 16.11.2024.
//

import Foundation
import NetworkProvider
import UIKit

protocol ProductsPresenterProtocol: AnyObject {
    func viewDidLoad()
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

    private(set) var sections: [SectionType] = []
    private var currentPage: Int = 1
    private var hasNextPage: Bool = true
    private var isLoading: Bool = false {
        didSet {
            view?.showLoading(isLoading)
        }
    }

    init(view: ProductsViewProtocol, interactor: ProductsInteractorProtocol, router: ProductsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        isLoading = true
        interactor.fetchProducts(page: currentPage)
    }

    func fetchNextPage() {
        guard !isLoading, hasNextPage else {
            return
        }
        isLoading = true
        interactor.fetchProducts(page: currentPage)
    }

    func numberOfSections() -> Int {
        let sectionsCount: Int = sections.count
        return sectionsCount
    }

    func numberOfItems(in section: Int) -> Int {
        switch sections[section] {
        case .sponsored(let products):
            return products.count
        case .products(let products):
            return products.count
        }
    }

    func sectionType(at section: Int) -> SectionType {
        let sectionType: SectionType = sections[section]
        return sectionType
    }

    func product(at indexPath: IndexPath) -> ProductDisplayable {
        switch sections[indexPath.section] {
        case .sponsored(let products):
            return products[indexPath.item]
        case .products(let products):
            return products[indexPath.item]
        }
    }

    func didSelectProduct(_ product: ProductDisplayable) {
        guard let view = view as? BaseViewController else {
            return
        }

        router.navigateToDetail(from: view, with: product)
    }

}
// swiftlint:disable no_grouping_extension
extension ProductsPresenter: ProductsInteractorOutputProtocol {
    func didFetchProducts(_ response: ProductsResponse) {
        isLoading = false
        if let nextPage = response.nextPage {
            self.currentPage = Int(nextPage) ?? self.currentPage + 1
        } else {
            self.hasNextPage = false
        }

        if let sponsored = response.sponsoredProducts, !sponsored.isEmpty {
            sections.append(.sponsored(sponsored))
        }
        sections.append(.products(response.products))

        view?.showProducts()
    }

    func didFailToFetchProducts(_ error: Error) {
        isLoading = false
        view?.showError("Failed to load products")
    }

}
// swiftlint:enable no_grouping_extension
enum SectionType {
    case sponsored([SponsoredProduct])
    case products([Product])
}
