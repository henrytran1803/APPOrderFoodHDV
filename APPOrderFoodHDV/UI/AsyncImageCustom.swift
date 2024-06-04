//
//  AsyncImageCustom.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 12/05/2024.
//

import SwiftUI
struct AsyncImageCustom : View {
    @State var url : String
    @State var framew : CGFloat
    @State var corner : CGFloat
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty: ZStack { Color.gray; ProgressView() }
            case .success(let image): image.resizable()
            case .failure(let error):
                Text(error.localizedDescription)
            }
        }
        .aspectRatio(contentMode: .fit)
        .frame(width: framew)
        .cornerRadius(corner)
    }
}

