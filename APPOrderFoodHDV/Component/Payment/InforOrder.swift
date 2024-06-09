//
//  InforOrder.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import SwiftUI

struct InforOrder: View {
    @Binding var order: OrderCreate
    @ObservedObject var model = UserViewModel()
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .frame(width: .infinity, height: 300)
            .foregroundColor(.secondary)
            .overlay{
                List{
                    Section(header: Text("Infomation Order")) {
                        HStack(alignment: .top, spacing: 0){
                            Text("Address: ")
                                .bold()
                            Text("\(model.user.username)")
                        }
                        HStack(alignment: .top, spacing: 0){
                            Text("Address: ")
                                .bold()
                            Text("\(model.user.username)")
                        }
                        HStack(alignment: .top, spacing: 0){
                            Text("Address: ")
                                .bold()
                            Text("\(model.user.address)")
                        }
                        HStack(alignment: .top, spacing: 0){
                            Text("total: ")
                                .bold()
                            Text("\(order.orderFee)")
                        }
                        HStack(alignment: .top, spacing: 0){
                            Text("Status: ")
                                .bold()
                            Text("In comming")
                        }
                    }.foregroundColor(.secondary)
                }
            }
    }
}


