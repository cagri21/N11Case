//
//  UICollectionView+Ext.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import XCTest
import UIKit
@testable import N11Case

final class UICollectionViewExtTests: XCTestCase {

    var collectionView: UICollectionView!
    var mockDataSource: MockDataSource!
    override func setUp() {
        super.setUp()
        // Create a UICollectionView instance with a basic layout
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mockDataSource = MockDataSource()
    }

    override func tearDown() {
        collectionView = nil
        super.tearDown()
    }

    /// Test the `dequeueReusableCell` method
    func testDequeueReusableCell() {
        collectionView.register(MockCell.self)
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.dataSource = mockDataSource

        collectionView.reloadData()
        let cell: MockCell = collectionView.dequeueReusableCell(for: indexPath)

        XCTAssertNotNil(cell, "Dequeued cell should not be nil.")
    }
}

// MARK: - Mock Classes

/// Mock UICollectionViewCell for testing
final class MockCell: UICollectionViewCell {}

/// Mock UICollectionViewDataSource to handle `dequeueReusableCell` testing
final class MockDataSource: NSObject, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier:
                                                    String(describing: MockCell.self), for: indexPath)
    }
}
