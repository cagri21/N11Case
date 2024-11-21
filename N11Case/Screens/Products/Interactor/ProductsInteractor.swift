//
//  ProductsInteractor.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 16.11.2024.
//

import Foundation
import NetworkProvider

protocol ProductsInteractorProtocol: BaseInteractorProtocol where Entity == ProductsEntity {
    func fetchProducts(page: Int)
}

final class ProductsInteractor: ProductsInteractorProtocol {
    weak var presenter: (any ProductsInteractorOutputProtocol)?
    private let apiService: ProductsServiceProtocol
    private var entity: ProductsEntity

    init(apiService: ProductsServiceProtocol, entity: ProductsEntity ) {
        self.apiService = apiService
        self.entity = entity
    }

    func fetchProducts(page: Int) {
        apiService.fetchProducts(page: page, parameters: nil) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.processResponse(response)
            case .failure(let error):
                self.presenter?.didFailToFetchData(error)
            }
        }
    }

    func getEntity() -> ProductsEntity {
        let entity: ProductsEntity = entity
        return entity
    }

    private func processResponse(_ response: ProductsResponse) {
        entity.addProducts(response: response)
        presenter?.didFetchData(entity)
    }
}

protocol ProductsInteractorOutputProtocol: BaseInteractorOutputProtocol where Response == ProductsEntity {}
