//
//  SignUpView.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 12/05/2024.
//

import SwiftUI


struct SignUpView: View {
    @Binding var show : Bool
    @Binding var isSignin : Bool
    @State var isShowingSignup = false
    @State var isSuccess = false
    @State var isFail = false
    @State var signIn = false
    @State var repeatPassword = ""
    @State var showNoti = false
    @State var isOpenLocation = false
    @State var signUpmodel = SignUpViewModel()
    var body: some View {
            VStack{
                HStack{
                    Button(action: {
                        show.toggle()
                        isSignin.toggle()
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .frame(width: 30,height: 30)
                            .foregroundStyle(.black)
                    }).padding()
                    
                    Spacer()
                }
                
                Spacer()
                Text("Đăng ký tài khoản mới")
                    .bold()
                    .font(.title)
                    .foregroundColor(.primary)
                Text("Đăng ký ngay để được ăn ngon nhé")
                    .foregroundColor(.secondary)
                Spacer()
                TextField("Email", text:$signUpmodel.signup.email)
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
                TextField("Phone", text:$signUpmodel.signup.phone)
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
                TextField("UserName", text:$signUpmodel.signup.username)
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
                
                HStack{
                    let description = strengthDescription()
                    Rectangle()
                        .frame(width: description.2,height: 1)
                        .foregroundColor(description.1)
                        .animation(.easeInOut)
                    Text(description.0)
                        .foregroundStyle(.secondary)
                        .font(.system(size: 15))
                    Spacer()
                }
                
                SecureField("Password", text:$signUpmodel.signup.password)
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
                SecureField("Repeat password", text:$repeatPassword)
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
                HStack{
                    Text("Address:")
                        .bold()
                        .foregroundStyle(.secondary)
                    if signUpmodel.signup.address.isEmpty {
                        Text("Tìm địa chỉ")
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
                            .onTapGesture {
                                isOpenLocation.toggle()
                            }
                    }else {
                        Text(signUpmodel.signup.address)
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
                            .onTapGesture {
                                isOpenLocation.toggle()
                            }
                    }
                    Spacer()
                }
                Spacer()
                ButtonStyleWelcome(icon: "", title: "Đăng ký"){
                    if checkPass() {
                        signUpmodel.signUpUser { success, errorMessage in
                          if success {
                            print("Sign-up successful!")
                              isSuccess = true
                          } else {
                            print("Sign-up failed: \(errorMessage ?? "Unknown error")")
                              isFail = true
                          }
                        }
                    }else {
                        showNoti = true
                    }
                }.padding()
            }.padding()
                .opacity(show ? 1 :0)
                .scaleEffect(show ? 1 : 0.8)
                .alert("Important message: wrong pass", isPresented: $showNoti) {
                    Button("OK", role: .cancel) { }
                }
                .alert("Đăng ký thành công", isPresented: $isSuccess) {
                    Button("OK", role: .cancel) { }
                }
                .alert("Đã tồn tại", isPresented: $isFail) {
                    Button("OK", role: .cancel) { }
                }
                .sheet(isPresented: $isOpenLocation, content: {
                    SearchLocationView(signupmodel: $signUpmodel,  isOpenLocation: $isOpenLocation)
                })
    }
    func checkPass() -> Bool {
        if self.signUpmodel.signup.password != self.repeatPassword{
            return false
        }
        return true
    }
    private func strengthDescription() -> (String, Color, CGFloat) {
        let strength = PasswordStrengthChecker.checkStrength(signUpmodel.signup.password)
        switch strength {
        case .weak:
            return ("Yếu", Color.red, 50)
        case .moderate:
            return ("Vừa", Color.orange, 100)
        case .strong:
            return ("Mạnh", Color.green, 150)
        }
    }


}


enum PasswordStrength {
    case weak
    case moderate
    case strong
}

struct PasswordStrengthChecker {
    static func checkStrength(_ password: String) -> PasswordStrength {
        var score = 0
        
        if password.count >= 8 {
            score += 1
        }
        
        let uppercaseLetterRegex = ".*[A-Z]+.*"
        if NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex).evaluate(with: password) {
            score += 1
        }
        
        let specialCharacterRegex = ".*[^A-Za-z0-9]+.*"
        if NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex).evaluate(with: password) {
            score += 1
        }
        
        switch score {
        case 0...1:
            return .weak
        case 2:
            return .moderate
        default:
            return .strong
        }
    }
}

#Preview {
    SignUpView(show: .constant(true), isSignin: .constant(true))
}
