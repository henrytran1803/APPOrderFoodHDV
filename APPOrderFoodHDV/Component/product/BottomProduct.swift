//
//  BottomProduct.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 5/6/24.
//

import SwiftUI

struct BottomProduct: View {
    @State var product: Product
    @State var isClick = true
    @State private var count = 1
    @State private var totalPrice: Double = 0
    @State private var isAdd = false
    @ObservedObject private var cartItemModel = CartItemViewModel()
    @ObservedObject var model = FavoriteViewModel()

    var body: some View {
        VStack {
            if isClick {
                Spacer()
            }
            ZStack {
                
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color.white)
                    .frame(width: .infinity, height: isClick ? 400 : 0)
                    .animation(isClick ? .easeIn(duration: 1) : .easeOut(duration: 1), value: isClick)
                    .overlay(
                        VStack {
                            HStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundColor(Color("bgproduct"))
                                    .frame(width: 80, height: 50)
                                    .overlay(
                                        HStack {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text("\(String(format: "%.1f", 5))")
                                                .foregroundColor(.white)
                                        }
                                    )
                                Spacer()
                                HStack {
                                    Button(action: { decreaseCount() }) {
                                        Image(systemName: "minus.square.fill")
                                            .font(.system(size: 30))
                                            .foregroundColor(.green)
                                    }
                                    Text("\(count)")
                                    Button(action: { count += 1 }) {
                                        Image(systemName: "plus.square.fill")
                                            .font(.system(size: 30))
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                            .padding(.vertical)
                            HStack {
                                Text(product.name)
                                    .bold()
                                    .font(.title)
                                Spacer()
                                Button(action: { model.isFavorite.toggle()
                                    if model.isFavorite {
                                        model.addFavorite(productId: product.id)
                                    }else {
                                        model.deleteFavoriteById()
                                    }
                                }) {
                                    Image(systemName: model.isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(.pink)
                                }

                            }
                            .padding(.vertical)
                            HStack {
                                Text(product.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            Spacer()
                            HStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color("bgprice"))
                                    .frame(width: isAdd ? 0 : 148, height: isAdd ? 0 : 76)
                                    .overlay(
                                        VStack(alignment: .leading) {
                                            Text("Total price")
                                                .foregroundColor(.secondary)
                                            Text("\(String(format: "%.1f", totalPrice))")
                                                .foregroundColor(.black)
                                                .bold()
                                                .font(.system(size: 22))
                                        }
                                    )
                                Spacer()
                                Button(action: { isAdd = true
                                    cartItemModel.addItem(product, quantity: count)
                                    print(cartItemModel.items)
                                }) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(isAdd ? .green : Color("bgproduct"))
                                        .frame(width: isAdd ? .infinity : 148, height: 76)
                                        .overlay(
                                            HStack {
                                                Image(systemName: isAdd ? "checkmark.seal.fill" : "cart.fill")
                                                    .foregroundColor(isAdd ? .white : .green)
                                                Text(isAdd ? "SUCCESS" : "ADD TO CART")
                                                    .foregroundColor(.white)
                                                    .bold()
                                                    .font(.system(size: 15))
                                            }
                                        )
                                }
                            }
                        }
                        .padding([.leading, .bottom, .trailing])
                    )
            }
            .onAppear{
                model.checkIfProductIsFavorited(productId: product.id)
                print(model.isFavorite)
            }
        }
        .ignoresSafeArea()
        .onReceive([self.count].publisher.first()) { _ in
            self.totalPrice = Double(self.count) * self.product.price
        }
    }

    private func decreaseCount() {
        if count > 1 {
            count -= 1
        }
    }
}
