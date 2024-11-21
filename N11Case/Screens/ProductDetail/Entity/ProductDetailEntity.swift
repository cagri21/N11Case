//
//  ProductDetailEntity.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 21.11.2024.
//
import NetworkProvider

struct ProductDetailEntity {
    let product: ProductDisplayable

    init(product: ProductDisplayable) {
        self.product = product
    }
}
