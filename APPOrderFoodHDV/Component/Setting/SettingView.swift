//
//  SettingView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 4/6/24.
//


import SwiftUI
import TipKit

struct StatusTip: Tip {
    var title: Text {
        Text("Trạng thái")
    }
    var message: Text? {
        Text("Đây là trạng thái các đơn hàng của bạn.")
    }

    var image: Image? {
        Image(systemName: "questionmark.circle")
    }
}
struct SettingView: View {
    @State var isShowProfile = false
    
    @State var isOpenAddCate = false
    @State var isOpenDiscount = false
    @State var isLogout = false
    var statusTip = StatusTip()
    @ObservedObject var userModel = UserViewModel()
    @Environment(\.openURL) var openURL
    private var deepLinkService = DeepLinkService()
    var body: some View {
        NavigationStack{
            VStack{
                Image("bgimgprofile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 170)
                    .overlay{
                        HStack {
                            Circle()
                                .frame(height: 100)

                            VStack(alignment: .leading) {
                                Text("Username: \(userModel.user.username)")
                                    Text("Addresss: \(userModel.user.address) ")
                                    Text("Email: \(userModel.user.email)")
                                
                            }
                            .padding()
                            .font(.body)
                            Spacer()
                        }
                        .padding()
                    }
                List {
                    
                    Section(header: Text("Trạng thái")){
                        TipView(statusTip, arrowEdge: .bottom)
                        HStack{
                            VStack{
                                Image(systemName: "person.crop.circle.badge.checkmark")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 30))
                                Text("3")
                                    .foregroundStyle(.red)
                            }
                            
                            Spacer()
                            VStack{
                                Image(systemName: "archivebox.circle")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 30))
                                Text("3")
                                    .foregroundStyle(.red)
                            }
                            Spacer()
                            VStack{
                                Image(systemName: "truck.box.badge.clock")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 30))
                                Text("3")
                                    .foregroundStyle(.red)
                            }
                            Spacer()
                            VStack{
                                Image(systemName: "star")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 30))
                                Text("3")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    
                    Section(header: Text("Tài khoản")){
                        NavigationLink(destination: ProfileView()) {
                            Text("Thông tin cá nhân")
                        }.foregroundColor(.black)
                        NavigationLink(destination: FavoriteView()) {
                            Text("Lịch sử yêu thích")
                        }.foregroundColor(.black)
                        NavigationLink(destination: OrderView()) {
                            Text("Lịch sử đơn hàng")
                        }.foregroundColor(.black)
                    }
                    Section(header: Text("Hỗ trợ")){
                        Button {
                            deepLinkService.openURL(type: .email("tranvietanh1803@gmail.com"), openURLAction: openURL)
                        } label: {
                            Text("Email hỗ trợ")
                        }.foregroundColor(.black)
                        Button {
                            deepLinkService.openURL(type: .phone("0365899252"), openURLAction: openURL)
                        } label: {
                            Text("Liên Hệ trực tiếp")
                        }.foregroundColor(.black)
                    }
                    Section(header: Text("Ứng dụng")){
                        Button {
                            logout()
                            isLogout = true
                        } label: {
                            Text("Đăng xuất")
                                .foregroundStyle(.red)
                        }

                    }
                }
            }
           
        }.ignoresSafeArea()
            .task {
                try? Tips.configure([
                    .displayFrequency(.immediate),
                    .datastoreLocation(.applicationDefault)
                ])
  
            }
            .fullScreenCover(isPresented: $isLogout, content: {
                WelcomeView()
            })

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
