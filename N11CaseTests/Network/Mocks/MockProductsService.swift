//
//  ProductServiceMock.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 22.11.2024.
//
import Foundation
import NetworkProvider
import Testing
import XCTest
@testable import N11Case
class MockProductsService: ProductsServiceProtocol {
    var mockResponseFile: String = "products"
    var shouldReturnError: Bool = false

    private let decoder: JSONDecoder = JSONDecoder()

    init() {
        decoder.dateDecodingStrategy = .formatted(.server)
    }

    func fetchProducts(page: Int, parameters: [URLQueryItem]?,
                       completion: @escaping ((Result<NetworkProvider.ProductsResponse,
                                               NetworkProvider.ExceptionHandler>) -> Void)) {

        if shouldReturnError {
            completion(.failure(ExceptionHandler.invalidFormat))
            return
        }

        mockResponseFile = "products"
        MockNetworkManager.sharedInstance.fetchData(from: mockResponseFile) { result in
            switch result {
            case .success(let data):
                do {
                    let products: ProductsResponse = try self.decoder.decode(NetworkProvider.ProductsResponse.self,
                                                                             from: data)
                    completion(.success(products))
                } catch {
                    XCTFail("'\(self.mockResponseFile).json' - parsing error")
                    completion(.failure(ExceptionHandler.invalidFormat))
                }
            case .failure(let error):
                XCTFail("'\(self.mockResponseFile).json' - error")
                completion(.failure(error))
            }
        }
    }

    func fetchProduct(productID: Int, parameters: [URLQueryItem]?,
                      completion: @escaping ((Result<NetworkProvider.ProductResponse,
                                              NetworkProvider.ExceptionHandler>) -> Void)) {
        if shouldReturnError {
            completion(.failure(ExceptionHandler.invalidFormat))
            return
        }

        mockResponseFile = "product"
        MockNetworkManager.sharedInstance.fetchData(from: mockResponseFile) { result in
            switch result {
            case .success(let data):
                do {
                    let product: ProductResponse = try self.decoder.decode(NetworkProvider.ProductResponse.self,
                                                                           from: data)
                    completion(.success(product))
                } catch {
                    XCTFail("'\(self.mockResponseFile).json' - parsing error")
                    completion(.failure(ExceptionHandler.invalidFormat))
                }
            case .failure(let error):
                XCTFail("'\(self.mockResponseFile).json' - error")
                completion(.failure(error))
            }
        }
    }
}
