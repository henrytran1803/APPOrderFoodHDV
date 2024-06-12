//
//  LoginViewModel.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 5/6/24.
//

import Foundation
class SignInViewModel: ObservableObject {
    @Published var signIn : SignIn = SignIn(username: "", password: "")
    var api = "http://127.0.0.1:9000/api/login/signin"
    func Login(completion: @escaping (Bool) -> Void) {
            guard let url = URL(string: api) else {
                print("URL không hợp lệ")
                completion(false)
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            let parameters = "email=\(signIn.username)&password=\(signIn.password)"
            request.httpBody = parameters.data(using: .utf8)

            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Lỗi khi gọi API: \(error.localizedDescription)")
                        completion(false)
                        return
                    }

                    guard let httpResponse = response as? HTTPURLResponse else {
                        print("Phản hồi không hợp lệ từ server")
                        completion(false)
                        return
                    }

                    guard (200...299).contains(httpResponse.statusCode), let data = data else {
                        print("Phản hồi không thành công từ server (mã trạng thái: \(httpResponse.statusCode))")
                        completion(false)
                        return
                    }

                    do {
                        let signInResponse = try JSONDecoder().decode(SignInResponse.self, from: data)
                        print(signInResponse)
                        UserDefaults.standard.set(signInResponse.data.token, forKey: "token")
                        UserDefaults.standard.set(signInResponse.data.id, forKey: "id_user")
                        UserDefaults.standard.set(true, forKey: "isLogin")
                        UserDefaults.standard.synchronize()
                        
                        print("Đăng nhập thành công: \(signInResponse.message)")
                        completion(true)
                    } catch {
                        print("Giải mã dữ liệu phản hồi thất bại: \(error.localizedDescription)")
                        completion(false)
                    }
                }
            }
            dataTask.resume()
        }
}
