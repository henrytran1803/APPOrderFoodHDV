//
//  PaymentWithCash.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import SwiftUI
import TipKit

struct FavoriteLandmarkTip: Tip {
    var title: Text {
        Text("Điều khoản.")
    }


    var message: Text? {
        Text("Chấp nhận điều khoản để tiếp tục hoàn thành đơn hàng.")
    }


    var image: Image? {
        Image(systemName: "book.pages")
    }
}
struct PaymentWithCash: View {
    @Binding var isAccept:Bool
    @State var isRule = false
    @State var order: OrderCreate
    var favoriteLandmarkTip = FavoriteLandmarkTip()
    var body: some View {
        NavigationStack{
            HStack{
                Text("TOTAL")
                    .bold()
                    .font(.title)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(String(format: "%.2f", order.orderFee))")
                    .bold()
                    .font(.title)
                    .foregroundStyle(.secondary)
            }.padding()
            HStack{
                Text("ADDRESS")
                    .bold()
                    .foregroundStyle(.secondary)
                Spacer()
                Text(order.orderDesc ?? "none")
                    .bold()
                    .foregroundStyle(.secondary)
            }.padding()
            HStack{
                Text("PAYMENT METHOD")
                    .bold()
                    .foregroundStyle(.secondary)
                Spacer()
            }.padding()
            Spacer()
            TipView(favoriteLandmarkTip, arrowEdge: .bottom)
            HStack{
                Button(action: {isAccept.toggle()}, label: {
                    Image(systemName: isAccept ? "checkmark.square.fill" : "square")
                        .foregroundColor(.black)
                })
                Text("Chấp nhận")
                Text("Điều khoản")
                    .bold()
                    .onTapGesture {
                        self.isRule = true
                    }
                NavigationLink(destination: RuleView(), isActive: self.$isRule) {
                    EmptyView()
                }
               
            }
            .task {
                try? Tips.configure([
                    .displayFrequency(.immediate),
                    .datastoreLocation(.applicationDefault)
                ])
            }
        }
    }
 
}

