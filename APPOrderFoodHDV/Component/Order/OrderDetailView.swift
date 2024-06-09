//
//  OrderDetailView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import SwiftUI

struct OrderDetailView: View {
    @State var order : Order
    var body: some View {
        VStack(alignment: .leading){
            Text("ID order: \(order.id)")
            Text("Mô tả: \(order.orderDesc)")
            Text("Sản phẩm: \(order.userId)")
            Text("Ngày đặt: \(order.orderDate)")
            Text("Tổng tiền: \(order.orderFee)")
            Text("Sản phẩm")
                .bold()
            List{
                ForEach(order.orderDetails, id: \.id){ product in
                    VStack{
                        Text("Id sản phẩm:\(product.id)")
                        Text("Số lượng: \(product.quantity)")
                        Text("Giá tiền: \(product.productPrice)")
                    }
                    
                }
            }
            Spacer()
        }
    }
}

