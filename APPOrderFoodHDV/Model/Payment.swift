//
//  Payment.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import Foundation

enum PaymentStatus: String, Codable {
    case notStarted = "NOT_STARTED"
    case inProgress = "IN_PROGRESS"
    case completed = "COMPLETED"
}

struct PaymentRequest: Codable {
    let idOrder: Int
    let idUser: Int
    let idPayed: Int
    let paymentStatus: PaymentStatus
}
