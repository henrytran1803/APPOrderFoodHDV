//
//  CartItem.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 6/6/24.
//

import Foundation
struct CartItem: Codable, Identifiable {
    var id: Int { productId } // Use productId as the id
    var productId: Int
    var quantity: Int

    // CodingKeys to map JSON keys to your properties
    enum CodingKeys: String, CodingKey {
        case productId
        case quantity
    }
}

