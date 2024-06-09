//
//  ItemCartView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 6/6/24.
//

import SwiftUI

struct ItemCartView: View {
    @State var product : Product
    @Binding var quantity : Int
    @ObservedObject var cartItemModel: CartItemViewModel
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
                .frame(width: .infinity,height: 100)
                .overlay{
                    HStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color("bgproduct"))
                            .frame(width: 80, height: 80)
                            .overlay{
                                if let imageData = Data(base64Encoded: product.imageData), let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70)
                                        .cornerRadius(10)
                                } else {
                                    Text("Invalid image data")
                                }
                            }
                        Spacer()
                        VStack(alignment: .leading){
                            Text("\(product.name)")
                                .font(.system(size: 23))
                            Text("\(String(format: "%.1f", product.price ))")
                                .bold()
                                .font(.system(size:20))
                        }
                        VStack{
                            Spacer()
                            HStack{
                                Button(action: {decreaseCount()}, label: {
                                    Image(systemName: "minus.square.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(Color.green)
                                })
                                .buttonStyle(PlainButtonStyle())
                                Text("\(quantity)")
                                Button(action: {increaseCount()}, label: {
                                    Image(systemName: "plus.square.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(Color.green)
                                })
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
        }.onReceive([self.quantity].publisher.first()) { _ in
        }
    }
    private func decreaseCount() {
        if quantity > 1 {
            cartItemModel.addItem(product, quantity: -1)
        }
    }

    private func increaseCount() {
        cartItemModel.addItem(product, quantity: 1)
    }



}

