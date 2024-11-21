//
//  BasePagination.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

/// A protocol for pagination to ensure reusability and flexibility.
protocol BasePaginationProtocol {
    var currentPage: Int { get set }
    var hasNextPage: Bool { get set }

    mutating func reset()
    mutating func nextPage()
}

/// A reusable base pagination structure that conforms to the protocol.
struct BasePagination: BasePaginationProtocol {
    var currentPage: Int = 1
    var hasNextPage: Bool = true

    /// Resets the pagination state to its initial values.
    mutating func reset() {
        currentPage = 1
        hasNextPage = true
    }

    /// Advances to the next page.
    mutating func nextPage() {
        currentPage += 1
    }
}
