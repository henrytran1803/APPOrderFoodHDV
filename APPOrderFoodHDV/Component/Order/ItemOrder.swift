//
//  ItemOrder.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import SwiftUI

struct ItemOrder: View {
    @State var order : Order
    var body: some View {
        HStack{
            Text("ID: \(order.id)")
                .bold()
            Spacer()
            VStack(alignment: .leading){
                Text("Total: \(order.orderFee)")
                Text("Date: \(order.orderDate)")
            }.foregroundColor(.secondary)
            Spacer()
                Text("\(order.orderDesc)")
                    .foregroundColor(.secondary)
        }
    }
}

