//
//  UserViewModel.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 5/6/24.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User = User(id: 0, username: "", email: "", createDate: "", phone: "", address: "", roles: 0)
    @Published var errorMessage: String?

    var apiString = "http://127.0.0.1:8080/api/users/"

//    init() {
//        fetchUser { success in
//            if success {
//                print("User fetched successfully")
//            } else {
//                print("Failed to fetch user")
//            }
//        }
//    }

    func fetchUser(completion: @escaping (Bool) -> Void) {
        guard let userId = UserDefaults.standard.string(forKey: "id_user") else {
            completion(false)
            return
        }
        print(userId)
        
        let apiID = apiString + userId
        guard let url = URL(string: apiID) else {
            completion(false)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    completion(false)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Invalid response from server")
                    self.errorMessage = "Invalid response from server"
                    completion(false)
                    return
                }
                
                guard let data = data else {
                    print("No data received from server")
                    self.errorMessage = "No data received from server"
                    completion(false)
                    return
                }
                
                do {
                    let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                    self.user = userResponse.data
                    print(self.user)
                    completion(true)
                } catch {
                    print("Failed to decode JSON: \(error.localizedDescription)")
                    self.errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                    completion(false)
                }
            }
        }
        
        dataTask.resume()
    }
}