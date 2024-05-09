//
//  Product.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 08/05/2024.
//

import Foundation
struct Product: Codable {
    let id: Int
    let name: String
    let image: String
    let price: Double
    let description: String
    let quantity: Int
    let createDate: Date
    let category: Category
}
struct ProductResponse: Codable {
    let statusCode: Int
    let message: String
    let data: [Product]
}
