//
//  DetailProductView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 5/6/24.
//

import SwiftUI

struct DetailProductView: View {
    @State var product: Product
    @Binding var isClick :Bool
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("bgproduct") )
                .frame(width:.infinity , height:.infinity)
                .overlay{
                    VStack{
                        HStack{
                            Button(action: {isClick.toggle()}, label: {
                                Image(systemName: "arrow.backward")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30))
                                    .padding()
                                    .padding(.top, 50)
                            })
                            Spacer()
                        }
                        if let imageData = Data(base64Encoded: product.imageData), let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 360)
                                .cornerRadius(20)
                        } else {
                            Text("Invalid image data")
                        }
                            Spacer()
                            BottomProduct(product: product)
                                .padding(.bottom,20)
                    }
                }
        }.ignoresSafeArea()
           
        
    }
}
