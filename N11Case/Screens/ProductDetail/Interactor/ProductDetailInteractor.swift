//
//  DetailInteractor.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import Foundation
import NetworkProvider

protocol ProductDetailInteractorProtocol: AnyObject {
    func fetchProduct(with product: ProductDisplayable)
}

final class ProductDetailInteractor: ProductDetailInteractorProtocol {
    
    weak var presenter: ProductDetailInteractorOutputProtocol?
    private let apiService: ProductsServiceProtocol

    init(apiService: ProductsServiceProtocol) {
        self.apiService = apiService
    }

    func fetchProduct(with product: ProductDisplayable) {
//        apiService.getProducts(page: page, parameters: nil) { [weak self] result in
//            guard let self = self else {
//                return
//            }
//            switch result {
//            case .success(let response):
//                self.presenter?.didFetchProducts(response)
//            case .failure(let error):
//                self.presenter?.didFailToFetchProducts(error)
//            }
//        }
    }
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
    func didFetchProduct(_ response: ProductDisplayable)
    func didFailToFetchProducts(_ error: Error)
}
