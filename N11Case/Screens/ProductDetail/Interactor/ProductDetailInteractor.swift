//
//  DetailInteractor.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import Foundation
import NetworkProvider

protocol ProductDetailInteractorProtocol: AnyObject {
    func fetchProduct()
}

final class ProductDetailInteractor: ProductDetailInteractorProtocol {
    weak var presenter: (any ProductDetailInteractorOutputProtocol)?
    private let apiService: ProductsServiceProtocol
    private var productEntity: ProductDetailEntity
    private let errorHandlingService: ErrorHandlingServiceProtocol

    init(apiService: ProductsServiceProtocol, entity: ProductDetailEntity, errorHandlingService: ErrorHandlingServiceProtocol) {
        self.apiService = apiService
        self.productEntity = entity
        self.errorHandlingService = errorHandlingService
    }

    func fetchProduct() {
        let productID: Int = productEntity.product.id
        apiService.fetchProduct(productID: productID, parameters: nil) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.presenter?.didFetchData(response)
            case .failure(let error):
                let errorMessage: String = errorHandlingService.getErrorMessage(for: error)
                self.presenter?.didFailToFetchData(errorMessage)
            }
        }
    }
    
}

protocol ProductDetailInteractorOutputProtocol: BaseInteractorOutputProtocol where Response == ProductResponse {}
