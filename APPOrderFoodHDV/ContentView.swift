//
//  ContentView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 08/05/2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        let isLogin = UserDefaults.standard.bool(forKey: "isLogin")
        if isLogin  {
            TabView()
        }else{
            WelcomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
