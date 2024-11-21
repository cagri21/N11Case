//
//  DetailInteractor.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import Foundation
import NetworkProvider

protocol ProductDetailInteractorProtocol: BaseInteractorProtocol where Entity == ProductDetailEntity {
    func fetchProduct()
}

final class ProductDetailInteractor: ProductDetailInteractorProtocol {
    weak var presenter: (any ProductDetailInteractorOutputProtocol)?
    private let apiService: ProductsServiceProtocol
    private(set) var entity: ProductDetailEntity // Presenter can access, but only Interactor can modify
    private let errorHandlingService: ErrorHandlingServiceProtocol

    init(apiService: ProductsServiceProtocol, entity: ProductDetailEntity, errorHandlingService: ErrorHandlingServiceProtocol) {
        self.apiService = apiService
        self.entity = entity
        self.errorHandlingService = errorHandlingService
    }

    func fetchProduct() {
        let productID: Int = entity.product.id
        apiService.fetchProduct(productID: productID, parameters: nil) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.updateProductDetail(with: response)
                self.presenter?.didFetchData()
            case .failure(let error):
                let errorMessage: String = errorHandlingService.getErrorMessage(for: error)
                self.presenter?.didFailToFetchData(errorMessage)
            }
        }
    }

    private func updateProductDetail(with response: ProductResponse) {
        entity.updateProductDetail(with: response)
    }

}

protocol ProductDetailInteractorOutputProtocol: BaseInteractorOutputProtocol where Response == ProductResponse {}
