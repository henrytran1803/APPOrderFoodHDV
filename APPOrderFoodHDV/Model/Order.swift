//
//  Order.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import Foundation
struct Order: Codable, Identifiable {
    var id: Int
    var orderDesc: String?
    var orderFee: Double
    var orderDate: String?
    var userId: Int
    var orderDetails: [OrderDetail]
}
struct OrderCreate: Codable {
    var orderDesc: String
    var orderFee: Double
    var userId: Int
    var orderDetails: [CartItem]
}

struct OrderDetail: Codable, Identifiable {
    var id: Int
    var productId: Int
    var quantity: Int
    var productName: String?
    var productPrice: Double?
    var productImage: String?
}
struct OrderResponse: Codable {
    var statusCode: Int
    var message: String
    var data: [Order]
}
struct OrderResponseCreate: Codable {
    var statusCode: Int
    var message: String
    var data: Int
}
//NOT_STARTED("not_started"),
// IN_PROGRESS("in_progress"),
// COMPLETED("completed");
