//
//  Category.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 08/05/2024.
//

import Foundation
struct Category: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
}
struct CategoryResponse: Codable {
    let statusCode: Int
    let message: String
    let data: [Category]
}
