//
//  HomeView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 4/6/24.
//

import SwiftUI


struct HomeView: View {
    @State var searchText = ""
    @State var isLoading = false
    @State var listCategory: [Category] = []
    @ObservedObject var userModel = UserViewModel()
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    VStack(alignment: .leading) {
                        Text("Xin chào, \(userModel.user.username)")
                        Text("Chào mừng trở lại!")
                    }
                    Spacer()
                }.padding(.horizontal)
                TextField("", text: $searchText)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Tìm kiếm")
                            Spacer()
                        }.padding(.leading)
                            .padding(.horizontal, 16)
                            .foregroundColor(.gray)
                    )
                ListCategory(listCategory: $listCategory)
                HStack{
                    Text("Favorite")
                        .font(.title2)
                        .bold()
                        .padding()
                    Spacer()
                }
                ListProducts(listCategory: $listCategory, searchText: $searchText )
                
                
            }.padding(.top, 60)
        }
            .onAppear {
                userModel.fetchUser{success in
                    
                }
            }
        
    }

}

#Preview {
    HomeView()
}
