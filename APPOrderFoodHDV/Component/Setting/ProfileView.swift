//
//  ProfileView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 6/6/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var userModel = UserViewModel()
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ChangeView(text: "User Name", text2: $userModel.user.username)) {
                    Text("User name: \(userModel.user.username)")
                }.foregroundColor(.black)
                NavigationLink(destination: ChangeView(text: "Email", text2: $userModel.user.email)) {
                    Text("Email: \(userModel.user.email)")
                }.foregroundColor(.black)
                NavigationLink(destination: ChangeView(text: "Address", text2: $userModel.user.address)) {
                    Text("Address: \(userModel.user.address)")
                }.foregroundColor(.black)
                NavigationLink(destination: ChangeView(text: "Phone", text2: $userModel.user.phone)) {
                    Text("Phone: \(userModel.user.phone)")
                }.foregroundColor(.black)
            }
        }.onDisappear{
            userModel.updateUser(userInput: userModel.user){ success in
                if success {
                    print("thanh cong")
                }
                
            }
        }
    }
        
}

#Preview {
    ProfileView()
}
