//
//  CheckoutView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import SwiftUI

struct CheckoutView: View {
    @Binding var order : OrderCreate
    var body: some View {
//        if(order.payment == .cash){
//            //SuccessView(order: $order)
//        }else{
//           // PaymentWithCrypto(order: $order)
//        }
        VStack{
            SuccessView(order: $order)
        }
    }
}
