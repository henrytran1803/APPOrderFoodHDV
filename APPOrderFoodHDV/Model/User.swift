//
//  User.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 5/6/24.
//

import Foundation
struct User: Codable {
    let id: Int
    let username: String
    let email: String
    let createDate: String
    let phone: String
    let address: String
    let roles: Int
}
struct UserResponse : Codable{
    let statusCode: Int
    let message: String
    let data: User
}
