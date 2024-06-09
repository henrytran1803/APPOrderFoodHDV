//
//  ChangeView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 6/6/24.
//

import SwiftUI

struct ChangeView: View {
    @State var  text : String
    @Binding var  text2 : String
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack{
            TextField("",text: $text2)
                .padding()
                .border(Color.black)
                .padding()
            Spacer()
            .navigationTitle(text)
            .toolbar {
                  Button("Save") {
                      dismiss()
                }
            }
        }.background(Color.secondary)
    }
}

#Preview {
    ChangeView(text: "aaa", text2: .constant("aâ"))
}
