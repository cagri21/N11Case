//
//  ProductsInteractor.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 16.11.2024.
//

import Foundation
import NetworkProvider

protocol ProductsInteractorProtocol: AnyObject {
    func fetchProducts(page: Int)
}

final class ProductsInteractor: ProductsInteractorProtocol {
    weak var presenter: ProductsInteractorOutputProtocol?
    private let apiService: ProductsServiceProtocol

    init(apiService: ProductsServiceProtocol) {
        self.apiService = apiService
    }

    func fetchProducts(page: Int) {
        apiService.retrieveProducts(page: page, parameters: nil) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.presenter?.didFetchProducts(response)
            case .failure(let error):
                self.presenter?.didFailToFetchProducts(error)
            }
        }
    }
}

protocol ProductsInteractorOutputProtocol: AnyObject {
    func didFetchProducts(_ response: ProductsResponse)
    func didFailToFetchProducts(_ error: Error)
}
