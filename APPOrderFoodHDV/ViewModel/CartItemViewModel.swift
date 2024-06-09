//
//  CartItemViewModel.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 6/6/24.
//

import Foundation
class CartItemViewModel: ObservableObject {
    @Published var items: [CartItem] = []
    
    init() {
        loadCart()
    }

    func addItem(_ product: Product, quantity : Int) {
        if let index = items.firstIndex(where: { $0.id == product.id }) {
            items[index].quantity += quantity
        } else {
            items.append(CartItem(productId: product.id, quantity: quantity))
        }
        saveCart()
    }
    
    func removeItem(_ product: Product) {
        if let index = items.firstIndex(where: { $0.id == product.id }) {
            items.remove(at: index)
            saveCart()
        }
    }
    
    func saveCart() {
        if let encoded = try? JSONEncoder().encode(items) {
            print(encoded)
            UserDefaults.standard.set(encoded, forKey: "CartItems")
        }
    }
    
    func loadCart() {
        if let savedItems = UserDefaults.standard.data(forKey: "CartItems"),
           let decodedItems = try? JSONDecoder().decode([CartItem].self, from: savedItems) {
            items = decodedItems
        }
    }
}
