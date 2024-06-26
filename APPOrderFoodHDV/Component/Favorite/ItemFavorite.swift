//
//  ItemFavorite.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import SwiftUI

struct ItemFavorite: View {
    @State var product: Favorite
    @ObservedObject var model = FavoriteViewModel()
    var body: some View {
        HStack{
            VStack{
                Text(product.product.name)
                    .bold()
                Text(product.product.createDate)
            }
            Spacer()
            Button(action: {
                model.idFavorite = product.id
                    model.deleteFavoriteById()
            }) {
                Image(systemName: model.isFavorite ? "heart" : "heart.fill")
                    .foregroundColor(.pink)
            }
        }
    }
}

//#Preview {
//    ItemFavorite(.)
//}
