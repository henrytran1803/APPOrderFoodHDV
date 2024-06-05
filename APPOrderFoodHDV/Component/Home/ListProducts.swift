//
//  ListProducts.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 5/6/24.
//

import SwiftUI

struct ListProducts: View {
    @Binding var listCategory: [Category]
    @State private var selectedProduct: Product?
    @State private var isPresentingDetail = false
    @Binding var searchText: String
    @ObservedObject var productModel = ProductListViewModel()
    
    var columns: [GridItem] = [
        GridItem(.fixed(190)),
        GridItem(.fixed(190))
    ]
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(filteredProduct, id: \.id) { product in
                            ProductView(product: product)
                                .frame(width: geometry.size.width / 2 - 10)
                                .onTapGesture {
                                    self.selectedProduct = product
                                    self.isPresentingDetail = true
                                }
                        }
                    }
                    .padding()
                }
            }
        }
        .fullScreenCover(isPresented: Binding<Bool>(
            get: { selectedProduct != nil && isPresentingDetail },
            set: { _ in isPresentingDetail = false }
        )) {
            if let selectedProduct = selectedProduct {
                DetailProductView(product: selectedProduct, isClick: $isPresentingDetail)
                    .onDisappear {
                        self.selectedProduct = nil
                    }
            }
        }
    }
    var filteredProduct: [Product] {
        var products = productModel.products
        
        // Filter by search text
        if !searchText.isEmpty {
            products = products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        // Filter by selected categories if listCategory is not empty
        if !listCategory.isEmpty {
            products = products.filter { product in
                listCategory.contains(product.category)
            }
        }
        
        return products
    }
}
//
//struct ListProducts_Previews: PreviewProvider {
//    static var previews: some View {
//        ListProducts(searchText: .constant(""))
//    }
//}
