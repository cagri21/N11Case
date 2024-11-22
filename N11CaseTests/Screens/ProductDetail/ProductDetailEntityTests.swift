//
//  Untitled.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 22.11.2024.
//
import NetworkProvider
import XCTest
@testable import N11Case

final class ProductDetailEntityTests: XCTestCase {

    func testInitialization() {
        let mockProduct = MockProductDisplayable(id: 1,
                                                 title: "Test Product",
                                                 image: "https://example.com/image.jpg",
                                                 price: 99.99)

        let entity = ProductDetailEntity(product: mockProduct)

        XCTAssertEqual(entity.product.id, mockProduct.id, "Product ID should match the mocked product.")
        XCTAssertEqual(entity.product.title, mockProduct.title, "Product title should match the mocked product.")
        XCTAssertEqual(entity.product.price, mockProduct.price, "Product price should match the mocked product.")
        XCTAssertNil(entity.productDetail, "Product detail should be nil initially.")
    }

    func testUpdateProductDetail() {
        let mockProduct = MockProductDisplayable(id: 1,
                                                 title: "Test Product",
                                                 image: "https://example.com/image.jpg",
                                                 price: 99.99)
        var entity = ProductDetailEntity(product: mockProduct)

        guard let mockResponse = parseMockResponse(from: "product") else {
                XCTFail("Failed to parse mock response from JSON.")
                return
            }

        entity.updateProductDetail(with: mockResponse)

        XCTAssertNotNil(entity.productDetail, "Product detail should not be nil after updating.")
        XCTAssertEqual(entity.productDetail?.description, mockResponse.description,
                       "Product detail description should match the response.")
        XCTAssertEqual(entity.productDetail?.price, mockResponse.price,
                       "Product price should match the response.")
    }
}

private func parseMockResponse(from fileName: String) -> ProductResponse? {
    guard let filePath = Bundle(for: ProductDetailEntityTests.self).path(forResource: fileName, ofType: "json"),
          let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
        XCTFail("Failed to locate or read file \(fileName).json in the test bundle.")
        return nil
    }

    do {
        let decoder = JSONDecoder()
        let mockResponse = try decoder.decode(ProductResponse.self, from: jsonData)
        return mockResponse
    } catch {
        XCTFail("Failed to decode ProductResponse from file \(fileName).json: \(error.localizedDescription)")
        return nil
    }
}
