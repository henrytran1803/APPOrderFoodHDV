//
//  TabView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 4/6/24.
//

import SwiftUI
struct TabView: View {
    @State private var tabSelected: Tab = .house

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack {
            VStack {
                switch tabSelected {
                case .house:
                    HomeView()
                case .cart:
                    CartView()
                case .person:
                    SettingView()
                }

                Spacer()
            }
            VStack {
                Spacer()
                TabBarCustom(selectedTab: $tabSelected)
                
            }
        }.ignoresSafeArea()
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}

