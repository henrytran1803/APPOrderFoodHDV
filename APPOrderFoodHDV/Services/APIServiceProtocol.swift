//
//  APIServiceProtocol.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 12/05/2024.
//

import Foundation


protocol APIServiceProtocol {
    func fetchProducts(url: URL?, completion: @escaping(Result<[Product], APIError>) -> Void)
}
