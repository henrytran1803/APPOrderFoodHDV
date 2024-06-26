//
//  TabBarCustom.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 12/05/2024.
//

import SwiftUI
enum Tab: String, CaseIterable {
    case house
    case cart
    case person
}
struct TabBarCustom: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .foregroundColor(tab == selectedTab ? .white : .gray)
                        .font(.system(size: 20))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 70)
            .background(Color("bgproduct"))
            .cornerRadius(20)
            .padding()
        }
    }
}

#Preview {
    TabBarCustom(selectedTab: .constant(.house))
}




