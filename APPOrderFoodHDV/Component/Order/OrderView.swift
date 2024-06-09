//
//  OrderView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var model = OrderViewModel()
    var body: some View {
        NavigationStack{
            Text("\(model.orders.count)")
            List{
                ForEach(model.orders,id: \.id){order in
                    NavigationLink(destination: OrderDetailView(order: order)) {
                        ItemOrder(order: order)
                    }.foregroundColor(.black)
                }
            }
        }.onAppear{
            model.fetchAllOrdersByUserId()
        }
    }
}

#Preview {
    OrderView()
}
