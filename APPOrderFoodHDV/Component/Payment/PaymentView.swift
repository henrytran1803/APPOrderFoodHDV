//
//  PaymentView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import SwiftUI

struct PaymentView: View {
    @Binding var selectedRadioButton: String
    @Binding var  isCheckout: checkout
    @State var isAccept = false
    @State var order: OrderCreate
    @ObservedObject var model = OrderViewModel()
    @ObservedObject var modelPayment = PaymentViewModel()
    
    var body: some View {
        VStack{
            if selectedRadioButton == "Cash" {
                PaymentWithCash(isAccept : $isAccept, order: order)
            }else {
                PaymentWithVNPAY()
            }
            Button(action: {
                isCheckout  = .success
                model.postOrder(orderRequest: order)
                UserDefaults.standard.set("", forKey: "CartItems")
                let userid = UserDefaults.standard.integer(forKey: "id_user")
                let orderid = UserDefaults.standard.integer(forKey: "orderID")
                print(orderid)
                
                let payment = PaymentRequest(idOrder: orderid, idUser: userid, idPayed: 0, paymentStatus:.notStarted)
                print(payment)
                modelPayment.postPayment(paymentRequest: payment)
            }, label: {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(Color("bgproduct"))
                    .frame(width: .infinity, height: 60)
                    .overlay{
                        HStack{
                            Text("NEXT")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                            Image(systemName: "arrowtriangle.right.fill")
                                .foregroundColor(Color("bgbutton"))
                                .font(.system(size: 20))
                        }
                    }
            }).disabled(!isAccept)
            .padding([.leading, .trailing])
                .padding(.bottom, 70)
        }
      
    }

}
