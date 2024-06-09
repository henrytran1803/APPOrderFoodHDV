//
//  Favorite.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 8/6/24.
//

import Foundation
struct ProductFavorite: Codable {
    var id: Int
    var name: String
    var image: String
    var price: Double
    var description: String
    var quantity: Int
    var createDate: String
}
struct Favorite: Codable {
    var id: Int
    var userId: Int
    var productId: Int
    var product: ProductFavorite
}
struct FavouriteResponse: Codable {
    var statusCode: Int
    var message: String
    var data: [Favorite]
}

struct CheckFavoriteResponse: Codable {
    var statusCode: Int
    var message: String
    var data: Int
}

struct CheckFavorite: Codable {
    let result: Int
}
