//
//  LogInView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 12/05/2024.
//

import SwiftUI

struct LogInView: View {
    @Binding var show : Bool
    @Binding var isSignup : Bool
    @State var signInModel = SignInViewModel()
    @State var isLoginSuccess = false
    @State var alert = false
    @State var isSucess = false
    @State var isWrong = false
    @State var isEmpty = false
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                        show.toggle()
                    isSignup.toggle()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .frame(width: 30,height: 30)
                        .foregroundStyle(.black)
                }).padding()
                
                Spacer()
            }
            Spacer()
            Text("Chào mừng quay trở lại")
                .bold()
                .font(.title)
                .foregroundColor(.primary)
            Text("Đăng nhập để được ăn ngon nhé")
                .foregroundColor(.secondary)
            Spacer()
            TextField("User name", text:$signInModel.signIn.username)
                .padding()
                .background(Color(.white))
                .cornerRadius(8)
                .font(.system(size: 14))
                .multilineTextAlignment(.leading)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 0.1)
                        .foregroundStyle(.black)
                }
            SecureField("Password", text:$signInModel.signIn.password)
                .padding()
                .background(Color(.white))
                .cornerRadius(8)
                .font(.system(size: 14))
                .multilineTextAlignment(.leading)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 0.1)
                        .foregroundStyle(.black)
                }
        Spacer()
            ButtonStyleWelcome(icon: "", title: "Đăng nhập"){
                if signInModel.signIn.username.isEmpty || signInModel.signIn.password.isEmpty {
                    isEmpty = true
                }else {
                    signInModel.Login{success in
                        if success {
                            isSucess = true
                        } else {
                            isWrong = true
                        }
                        
                    }
                }
            }.padding()
        }.padding()
            .opacity(show ? 1 :0)
            .scaleEffect(show ? 1 : 0.8)
            .fullScreenCover(isPresented: $isLoginSuccess, content: {
                
                                
            })
            .alert("Sai tên đăng nhập hoặc mật khẩu", isPresented: $isWrong) {
                        Button("OK", role: .cancel) { }
                    }
            .alert("Đừng bỏ trống", isPresented: $isEmpty) {
                        Button("OK", role: .cancel) { }
                    }
            .fullScreenCover(isPresented: $isSucess, content: {
                TabView()
            })
    }
}

#Preview {
    LogInView(show: .constant(false), isSignup: .constant(true))
}
