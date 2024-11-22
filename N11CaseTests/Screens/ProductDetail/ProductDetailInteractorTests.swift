//
//  Untitled.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 22.11.2024.
//
import NetworkProvider
import XCTest
@testable import N11Case

final class ProductDetailInteractorTests: XCTestCase {

    // MARK: - Properties
    private var interactor: ProductDetailInteractor!
    private var mockPresenter: MockPresenter!
    private var mockService: MockProductsService!

    // MARK: - Mock Classes
    private class MockPresenter: ProductDetailInteractorOutputProtocol {

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
        guard let product = extractFirstProduct(from: "products") else {
                XCTFail("Failed to extract a product from products.json.")
                return
        }
        mockPresenter = MockPresenter()
        mockService = MockProductsService()
        interactor = ProductDetailInteractor(apiService: mockService,
                                             entity: ProductDetailEntity(product: product),
                                             errorHandlingService: ErrorHandlingService() )
        interactor.presenter = mockPresenter
    }

    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        mockService = nil
        super.tearDown()
    }

    // MARK: - Test Cases

    func testFetchProduct_Success() {
        mockService.mockResponseFile = "product"

        interactor.fetchProduct()

        XCTAssertTrue(mockPresenter.didFetchDataCalled,
                      "Presenter's didFetchData should be called for a successful response.")
    }

    func testFetchProduct_Failure() {
        mockService.shouldReturnError = true

        interactor.fetchProduct()

        XCTAssertTrue(mockPresenter.didFailToFetchDataCalled,
                      "Presenter's didFailToFetchData should be called for a failure response.")
        XCTAssertEqual(mockPresenter.errorMessage,
                       "Sorry, the operation couldn\'t be completed. Server response in invalid format.")
    }
}

private func extractFirstProduct(from jsonFileName: String) -> ProductDisplayable? {
    guard let filePath = Bundle(for: ProductDetailInteractorTests.self).path(forResource: jsonFileName, ofType: "json"),
          let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
          let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
          let products = json["products"] as? [[String: Any]],
          let firstProduct = products.first else {
        return nil
    }

    return MockProductDisplayable(
        id: firstProduct["id"] as? Int ?? 0,
        title: firstProduct["title"] as? String ?? "",
        image: firstProduct["image"] as? String ?? "",
        price: firstProduct["price"] as? Double ?? 0.0 // Fixed the syntax error
    )
}

struct MockProductDisplayable: ProductDisplayable, Decodable {
    var id: Int
    var title: String
    var image: String
    var price: Double
    var instantDiscountPrice: Double?
    var rate: Double?
}
