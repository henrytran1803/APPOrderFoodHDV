//
//  FavoriteViewModel.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 8/6/24.
//

import Foundation
import Combine
class FavoriteViewModel : ObservableObject {
    @Published var products: [Favorite] = []
    @Published var isFavorite: Bool = false
    @Published var idFavorite:Int = 0
    @Published var errorMessage: String? = nil
    
    func checkIfProductIsFavorited( productId: Int) {
        let userId = UserDefaults.standard.integer(forKey: "id_user")
        guard let url = URL(string: "http://127.0.0.1:9000/api/favourites/verify?userId=\(userId)&productId=\(productId)") else {
            self.errorMessage = "Invalid API URL"
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    self?.errorMessage = "Failed to check favorite status. Check server response."
                    return
                }

                guard let data = data else {
                    self?.errorMessage = "No data received from server."
                    return
                }
                 print("Raw response data: \(String(data: data, encoding: .utf8) ?? "Unable to decode data")")

                do {
                     let decodedResponse = try JSONDecoder().decode(CheckFavoriteResponse.self, from: data)
                     self?.isFavorite = (decodedResponse.data != 0)
                        self?.idFavorite = decodedResponse.data
                    print(decodedResponse.data )
                 } catch {
                     self?.errorMessage = "Error decoding JSON data: \(error.localizedDescription)"
                 }
            }
        }
        dataTask.resume()
    }
    func addFavorite(productId: Int) {
        let userId = UserDefaults.standard.integer(forKey: "id_user")
        guard let url = URL(string: "http://127.0.0.1:9000/api/favourites") else {
            print("Invalid API URL")
            return
        }

        let parameters = "idProduct=\(productId)&idUser=\(userId)"
        guard let parameterData = parameters.data(using: .utf8) else {
            print("Failed to encode parameters")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = parameterData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error adding favorite: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("Favorite added successfully")
                } else {
                    print("Failed to add favorite. Status code: \(httpResponse.statusCode)")
                }
            }
        }

        task.resume()
    }

    func deleteFavoriteById() {
        guard let url = URL(string: "http://127.0.0.1:9000/api/favourites/\(self.idFavorite)") else {
            print("Invalid API URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error deleting favorite: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("Favorite deleted successfully")
                } else {
                    print("Failed to delete favorite. Status code: \(httpResponse.statusCode)")
                }
            }
        }

        task.resume()
    }


    func fetchAllProductById() {
        let userId = UserDefaults.standard.integer(forKey: "id_user")
        let urlString = "http://127.0.0.1:9000/api/favourites/user/\(userId)"
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid API URL"
            return
        }
        
        print("Request URL: \(urlString)")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "Network error: \(error.localizedDescription)"
                    print("Network error: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    self?.errorMessage = "Invalid response from server"
                    print("Invalid response from server")
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
                    self?.errorMessage = "Server error: \(httpResponse.statusCode)"
                    print("Server error: \(httpResponse.statusCode)")
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "No data received from server"
                    print("No data received from server")
                    return
                }
                
                print("Raw response data: \(String(data: data, encoding: .utf8) ?? "Unable to decode data")")
                
                do {
                    let res = try JSONDecoder().decode(FavouriteResponse.self, from: data)
                    self?.products = res.data
                } catch {
                    self?.errorMessage = "Error decoding JSON data: \(error.localizedDescription)"
                    print("Error decoding JSON data: \(error.localizedDescription)")
                }
            }
        }
        
        dataTask.resume()
    }
}
