//
//  Untitled.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 22.11.2024.
//
import NetworkProvider
import XCTest
@testable import N11Case

final class ProductsPresenterTests: XCTestCase {

    private class MockView: ProductsViewProtocol {
        var showLoadingCalled = false
        var showDataCalled = false
        var showErrorMessage: String?

        func showLoading(_ isLoading: Bool) {
            showLoadingCalled = isLoading
        }

        func showData() {
            showDataCalled = true
        }

        func showError(_ message: String) {
            showErrorMessage = message
        }
    }

    private class MockInteractor: ProductsInteractorProtocol {
        var fetchProductsCalled = false
        var entity = ProductsEntity()

        func fetchProducts(page: Int) {
            fetchProductsCalled = true
        }
    }

    private class MockRouter: ProductsRouterProtocol {

        var navigateToDetailCalled = false
        var passedProduct: ProductDisplayable?

        func navigateToDetail(from view: Viewable, with entity: ProductDisplayable) {
            navigateToDetailCalled = true
            passedProduct = entity
        }

        func createModule() -> UIViewController {
            return ProductsViewController()
        }
    }

    private var presenter: ProductsPresenter!
    private var mockView: MockView!
    private var mockInteractor: MockInteractor!
    private var mockRouter: MockRouter!

    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockInteractor = MockInteractor()
        mockRouter = MockRouter()
        presenter = ProductsPresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }

    func testViewDidLoad_CallsInteractorFetchProducts() {
        presenter.viewDidLoad()
        XCTAssertTrue(mockInteractor.fetchProductsCalled)
        XCTAssertTrue(mockView.showLoadingCalled)
    }

    func testFetchNextPage_CallsInteractorWhenNotLoading() {
        mockInteractor.entity.pagination.hasNextPage = true
        presenter.fetchNextPage()
        XCTAssertTrue(mockInteractor.fetchProductsCalled)
    }

    func testDidFetchData_UpdatesView() {
        presenter.didFetchData()
        XCTAssertFalse(mockView.showLoadingCalled)
        XCTAssertTrue(mockView.showDataCalled)
    }

    func testDidFailToFetchData_ShowsError() {
        let errorMessage = "An error occurred"
        presenter.didFailToFetchData(errorMessage)
        XCTAssertFalse(mockView.showLoadingCalled)
        XCTAssertEqual(mockView.showErrorMessage, errorMessage)
    }

    func testCreateModule_ReturnsProperlyConfiguredViewController() {

        let module = mockRouter.createModule()

        XCTAssertNotNil(module, "The module should not be nil.")
        XCTAssertTrue(module is ProductsViewController, "The created module should be a ProductsViewController.")
    }
}
