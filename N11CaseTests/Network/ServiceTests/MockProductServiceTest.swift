//
//  MockProductServiceTest.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 22.11.2024.
//
import NetworkProvider
import XCTest
@testable import N11Case

class MockProductServiceTest: XCTestCase {

    let expectationName: String = "Product Service"
    let mockProductService: MockProductsService = MockProductsService()

    func testFetchProducts() {
        let exp: XCTestExpectation = expectation(description: expectationName)
        mockProductService.fetchProducts(page: 1, parameters: nil) { result in
            switch result {
            case .success:
                exp.fulfill()
            case .failure:
                XCTFail("Failure")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testFetchProduct() {
        let exp: XCTestExpectation = expectation(description: expectationName)
        mockProductService.fetchProduct(productID: 110, parameters: nil) { result in
            switch result {
            case .success:
                exp.fulfill()
            case .failure:
                XCTFail("Failure")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
