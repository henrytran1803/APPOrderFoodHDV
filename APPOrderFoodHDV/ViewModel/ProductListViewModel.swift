//
//  ProductListViewModel.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 6/6/24.
//

import Foundation
import Combine

class ProductListsViewModel: ObservableObject {
    @Published var products: [Product] = []
    private var cancellables = Set<AnyCancellable>()

    func fetchProducts(items: [CartItem]) {
        for item in items {
            fetchProduct(forItem: item)
        }
    }

    private func fetchProduct(forItem item: CartItem) {
        guard let url = URL(string: "http://127.0.0.1:9000/api/products/\(item.id)") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching product: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Bad server response")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let product = try JSONDecoder().decode(ProductSingleResponse.self, from: data)
                products.append(product.data)
            } catch {
                print("Error decoding product: \(error)")
            }
        }

        task.resume()
    }

}
