//
//  Untitled.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 22.11.2024.
//
import NetworkProvider
import XCTest
@testable import N11Case

final class ProductsInteractorTests: XCTestCase {

    // MARK: - Properties

    private var interactor: ProductsInteractor!
    private var mockPresenter: MockPresenter!
    private var mockService: MockProductsService!

    // MARK: - Mock Classes

    private class MockPresenter: ProductsInteractorOutputProtocol {
        var didFetchDataCalled = false
        var didFailToFetchDataCalled = false
        var errorMessage: String?

        func didFetchData() {
            didFetchDataCalled = true
        }

        func didFailToFetchData(_ message: String) {
            didFailToFetchDataCalled = true
            errorMessage = message
        }
    }

    // MARK: - Setup and Teardown

    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        mockService = MockProductsService()
        let entity = ProductsEntity()
        interactor = ProductsInteractor(apiService: mockService,
                                        entity: entity,
                                        errorHandlingService: ErrorHandlingService())
        interactor.presenter = mockPresenter
    }

    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        mockService = nil
        super.tearDown()
    }

    // MARK: - Test Methods

    func testFetchProducts_SuccessfulResponse() {
        mockService.mockResponseFile = "products" // Ensure this file exists in the test bundle

        interactor.fetchProducts(page: 1)

        XCTAssertTrue(mockPresenter.didFetchDataCalled,
                      "Presenter's didFetchData should be called for a successful response.")
        XCTAssertFalse(mockPresenter.didFailToFetchDataCalled,
                       "Presenter's didFailToFetchData should not be called for a successful response.")
        XCTAssertEqual(interactor.entity.sections.count, 2,
                       "Entity should have two sections: sponsored and products.")
    }

    func testFetchProducts_FailureResponse() {
        mockService.shouldReturnError = true

        interactor.fetchProducts(page: 1)

        XCTAssertTrue(mockPresenter.didFailToFetchDataCalled,
                      "Presenter's didFailToFetchData should be called for a failure response.")
        XCTAssertFalse(mockPresenter.didFetchDataCalled,
                       "Presenter's didFetchData should not be called for a failure response.")
        XCTAssertEqual(mockPresenter.errorMessage,
                       "Sorry, the operation couldn\'t be completed. Server response in invalid format.")
    }

    func testFetchProduct_SuccessfulResponse() {
        mockService.mockResponseFile = "product"

        interactor.fetchProducts(page: 1)

        XCTAssertTrue(mockPresenter.didFetchDataCalled,
                      "Presenter's didFetchData should be called for a successful response.")
    }

    func testFetchProduct_FailureResponse() {
        mockService.shouldReturnError = true

        interactor.fetchProducts(page: 1)

        XCTAssertTrue(mockPresenter.didFailToFetchDataCalled,
                      "Presenter's didFailToFetchData should be called for a failure response.")
        XCTAssertEqual(mockPresenter.errorMessage,
                       "Sorry, the operation couldn\'t be completed. Server response in invalid format.")
    }
}
