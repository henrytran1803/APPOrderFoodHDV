//
//  FavoriteView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var model = FavoriteViewModel()
    var body: some View {
        VStack{
            List{
                ForEach($model.products, id: \.id){product in
                    ItemFavorite(product: product)
                    
                }
            }
            
        }
       .onAppear{model.fetchAllProductById()}
    }
}

#Preview {
    FavoriteView()
}
