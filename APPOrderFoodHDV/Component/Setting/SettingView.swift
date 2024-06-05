//
//  SettingView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 4/6/24.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack{
            Spacer()
            Button(action: logout) {
                Label("Logout", systemImage: "power")
            }
            Spacer()
        }
    }
    func logout(){
        UserDefaults.standard.set("", forKey: "token")
        UserDefaults.standard.set("", forKey: "id_user")
        UserDefaults.standard.set(false, forKey: "isLogin")
    }
}

#Preview {
    SettingView()
}
