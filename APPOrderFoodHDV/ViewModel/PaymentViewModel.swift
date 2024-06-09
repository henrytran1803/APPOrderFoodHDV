//
//  PaymentViewModel.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 9/6/24.
//

import Foundation

class PaymentViewModel: ObservableObject {
    func postPayment(paymentRequest: PaymentRequest) {
        guard let url = URL(string: "http://localhost:9000/api/payments") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let formData = paymentRequest.toFormData()
        request.httpBody = formData
        
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
                print("Payment request successful")
            } else {
                print("Failed to post payment. Status code: \(httpResponse.statusCode)")
            }
        }
        
        task.resume()
    }
}

extension PaymentRequest {
    func toFormData() -> Data {
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "idOrder", value: "\(idOrder)"),
            URLQueryItem(name: "idUser", value: "\(idUser)"),
            URLQueryItem(name: "idPayed", value: "\(idPayed)"),
            URLQueryItem(name: "paymentStatus", value: paymentStatus.rawValue)
        ]
        return components.percentEncodedQuery?.data(using: .utf8) ?? Data()
    }
}
