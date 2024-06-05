//
//  ProductView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 5/6/24.
//

import SwiftUI

struct ProductView: View {
    @State var product: Product
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("bgproduct") )
                .frame(width:  170, height: 250)
                .overlay{
                    VStack{
                        if let imageData = Data(base64Encoded: product.imageData), let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 170)
                                .cornerRadius(25)
                        } else {
                            Text("Invalid image data")
                        }
                        Spacer()
                        VStack(alignment: .leading){
                            Text(product.name)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .bold()
                        }
                        HStack{
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(5)")
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(String(format: "%.2f",product.price))")
                                .foregroundColor(.white)
                        }.padding([.leading, .bottom, .trailing])
                    }
                }
        }
    }
}


