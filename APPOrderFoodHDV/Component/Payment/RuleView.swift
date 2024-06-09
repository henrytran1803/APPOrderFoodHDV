//
//  RuleView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import SwiftUI

struct RuleView: View {
    var body: some View {
                Text("Hello, World!")
                    .onAppear {
                        print("🔵 onAppear")
                    }
                    .onDisappear {
                        print("🔵 onDisappear")
                    }
    }
}

#Preview {
    RuleView()
}
