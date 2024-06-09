//
//  OrderViewModel.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import Foundation
class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = []
    @Published var errorMessage: String?
    
    func fetchAllOrdersByUserId() {
        let userId = UserDefaults.standard.integer(forKey: "id_user")
        let urlString = "http://localhost:9000/api/orders/user/\(userId)"
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                    self?.errorMessage = "Server error with status code \(statusCode)"
                    return
                }
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }
                print("Raw response data: \(String(data: data, encoding: .utf8) ?? "Unable to decode data")")

                do {
                    let orderResponse = try JSONDecoder().decode(OrderResponse.self, from: data)
                    self?.orders = orderResponse.data
                    print(self?.orders)
                } catch {
                    self?.errorMessage = "Error decoding JSON data: \(error.localizedDescription)"
                }
            }
        }
        
        dataTask.resume()
    }
    func postOrder(orderRequest: OrderCreate) {
        guard let url = URL(string: "http://localhost:9000/api/orders") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(orderRequest)
            request.httpBody = jsonData
        } catch {
            print("Error encoding order request: \(error)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Order request successful")
                
                if let responseData = data {
                    do {
                        let decoder = JSONDecoder()
                        let orderResponse = try decoder.decode(OrderResponseCreate.self, from: responseData)
                        UserDefaults.standard.set(orderResponse.data, forKey: "orderID")
                    } catch {
                        print("Error decoding order response: \(error)")
                    }
                } else {
                    print("No data received")
                }
            } else {
                print("Failed to post order. Status code: \(httpResponse.statusCode)")
            }
        }
        
        task.resume()
    }
}
