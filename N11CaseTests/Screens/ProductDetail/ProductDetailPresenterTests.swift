//
//  Untitled.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 22.11.2024.
//
import NetworkProvider
import XCTest
@testable import N11Case

final class ProductDetailPresenterTests: XCTestCase {

    // MARK: - Mock Classes

    private class MockView: ProductDetailViewProtocol {
        var showLoadingCalled = false
        var showProductDataCalled = false
        var showErrorMessage: String?

        func showLoading(_ isLoading: Bool) {
            showLoadingCalled = isLoading
        }

        func showData() {
            showProductDataCalled = true
        }

        func showError(_ message: String) {
            showErrorMessage = message
        }
    }

    private class MockInteractor: ProductDetailInteractorProtocol {
        var entity: ProductDetailEntity = ProductDetailEntity(
            product: MockProductDisplayable(id: 1,
                                            title: "Mock Product",
                                            image: "https://example.com/image.jpg",
                                            price: 99.99))
        var fetchProductCalled = false

        func fetchProduct() {
            fetchProductCalled = true
        }
    }

    private class MockRouter: ProductDetailRouterProtocol {
        func createModule(with product: any NetworkProvider.ProductDisplayable,
                          apiService: any NetworkProvider.ProductsServiceProtocol) -> UIViewController {
            return UIViewController()
        }

        var navigateCalled = false

        func navigateToAnotherScreen() {
            navigateCalled = true
        }
    }

    // MARK: - Properties

    private var presenter: ProductDetailPresenter!
    private var mockView: MockView!
    private var mockInteractor: MockInteractor!
    private var mockRouter: MockRouter!

    // MARK: - Setup and Teardown

    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockInteractor = MockInteractor()
        mockRouter = MockRouter()
        presenter = ProductDetailPresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }

    // MARK: - Test Cases

    func testViewDidLoad_CallsInteractorFetchProduct() {
        // Arrange
        let productID = 123

        // Act
        presenter.viewDidLoad()

        // Assert
        XCTAssertTrue(mockView.showLoadingCalled, "View should show loading when viewDidLoad is called.")
        XCTAssertTrue(mockInteractor.fetchProductCalled, "Interactor's fetchProduct should be called.")
    }

    func testDidFetchData_UpdatesView() {
        // Arrange
        let mockProduct = MockProductDisplayable(id: 1,
                                                 title: "Mock Product",
                                                 image: "https://example.com/image.jpg",
                                                 price: 99.99)

        // Act
        presenter.didFetchData()

        // Assert
        XCTAssertFalse(mockView.showLoadingCalled, "Loading should be hidden after data is fetched.")
        XCTAssertTrue(mockView.showProductDataCalled, "View's showProductData should be called after data is fetched.")
    }

    func testDidFailToFetchData_ShowsError() {
        // Arrange
        let errorMessage = "Failed to fetch product details."

        // Act
        presenter.didFailToFetchData(errorMessage)

        // Assert
        XCTAssertFalse(mockView.showLoadingCalled, "Loading should be hidden after a failure occurs.")
        XCTAssertEqual(mockView.showErrorMessage, errorMessage, "View should display the correct error message.")
    }
}
