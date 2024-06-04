//
//  ButtonCustom.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 12/05/2024.
//

import SwiftUI

struct ButtonStyleWelcome : View {
    var icon: String
    var title: String
    var action :()->Void
    
    
    var body: some View {
        Button{
            withAnimation {
                action()
            }
        }label: {
            HStack{
                if !icon.isEmpty {
                    Image(icon).resizable()
                        .frame(width: 30,height: 30)
                }
                Text(title).font(.title2)
                
            }
        }.foregroundStyle(.black)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.white, in:.rect(cornerRadius: 30))
            .overlay{
                RoundedRectangle(cornerRadius: 30)
                    .stroke(lineWidth: 0.1)
                    .foregroundStyle(.black)
            }
            
    }
}
struct PressEffectButtonStyle: ButtonStyle {
    var backgroundColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
