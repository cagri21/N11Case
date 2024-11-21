//
//  ProductsEntity.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import NetworkProvider

public enum SectionType {
    case sponsored([SponsoredProduct])
    case products([Product])
}

struct ProductsEntity {
    var sections: [SectionType] = []
    var pagination: BasePagination = BasePagination()

    mutating func reset() {
        sections.removeAll()
        pagination.reset()
    }

    mutating func addProducts(response: ProductsResponse) {
        if response.nextPage != nil {
            pagination.nextPage()
        } else {
            pagination.hasNextPage = false
        }

        // Add new sections
        if let sponsored = response.sponsoredProducts, !sponsored.isEmpty {
            sections.append(.sponsored(sponsored))
        }
        sections.append(.products(response.products))
    }
}
