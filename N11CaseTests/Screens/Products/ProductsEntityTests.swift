//
//  Untitled.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 22.11.2024.
//

import NetworkProvider
import XCTest
@testable import N11Case

final class ProductsEntityTests: XCTestCase {

    private var mockService: MockProductsService!

    override func setUp() {
        super.setUp()
        mockService = MockProductsService()
    }

    override func tearDown() {
        mockService = nil
        super.tearDown()
    }

    func testAddProducts_AppendsNewSections() {
        var entity = ProductsEntity()
        mockService.mockResponseFile = "products"

        let expectation = self.expectation(description: "Fetch Products")
        mockService.fetchProducts(page: 1, parameters: nil) { result in
            switch result {
            case .success(let mockResponse):
                entity.addProducts(response: mockResponse)
            case .failure:
                XCTFail("Fetch Products should succeed for this test.")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)

        XCTAssertEqual(entity.sections.count, 2, "Entity should have two sections: sponsored and products.")
    }

    func testReset_ClearsSectionsAndPagination() {
        var entity = ProductsEntity(
            sections: [.products([])],
            pagination: BasePagination()
        )
        mockService.mockResponseFile = "products" // Ensure this file exists in the test bundle

        let expectation = self.expectation(description: "Fetch Products")
        mockService.fetchProducts(page: 1, parameters: nil) { result in
            switch result {
            case .success(let mockResponse):
                entity.addProducts(response: mockResponse)
                entity.reset() // Reset after adding products
            case .failure:
                XCTFail("Fetch Products should succeed for this test.")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)

        XCTAssertTrue(entity.sections.isEmpty, "Entity sections should be empty after reset.")
        XCTAssertEqual(entity.pagination.currentPage, 1, "Pagination current page should reset to 1.")
    }
}
