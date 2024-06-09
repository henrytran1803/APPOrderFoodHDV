//
//  SuccessView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import SwiftUI

struct SuccessView: View {
    @State var tracking = false
    @Binding var order: OrderCreate
   
    var body: some View {
        VStack{
            Text("Hoàn thành đơn hàng")
                .bold()
                .font(.title)
                .foregroundStyle(.secondary)
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.green)
                .font(.system(size: 40))
            InforOrder(order: $order)
            Button(action: {
                tracking = true
            
            }, label: {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(Color("bgproduct"))
                    .frame(width: .infinity, height: 60)
                    .overlay{
                        HStack{
                            Text("THEO DOI DON HANG")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                            Image(systemName: "map.fill")
                                .foregroundColor(Color("bgbutton"))
                                .font(.system(size: 20))
                        }
                    }
            })
        }.onAppear{
            nofication()
        }
//        .fullScreenCover(isPresented: $tracking, content: {
//            TrackingView(order: order)
//        })
    }
    func nofication(){
        let content = UNMutableNotificationContent()
        content.title = "Đặt hàng thành công"
        content.subtitle = "Đợi nhé"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        print("run")
    }
}

