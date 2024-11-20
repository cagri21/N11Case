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
}
