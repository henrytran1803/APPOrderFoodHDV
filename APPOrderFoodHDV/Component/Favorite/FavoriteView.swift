//
//  FavoriteView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var model = FavoriteViewModel()
    @State private var searchText = ""
    var body: some View {
        VStack{
            List{
                ForEach(filtereProduct, id: \.id){product in
                    ItemFavorite(product: product)
                    
                }
            }
            
        }
       .onAppear{model.fetchAllProductById()}
       .searchable(text: $searchText, prompt: "Look for something")
}
var filtereProduct: [Favorite] {
   if searchText.isEmpty {
       return model.products
   } else {
       return model.products.filter { $0.product.name.lowercased().contains(searchText.lowercased()) }
   }
}}

#Preview {
    FavoriteView()
}
