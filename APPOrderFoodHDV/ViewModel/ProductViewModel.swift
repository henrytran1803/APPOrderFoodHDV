//
//  ProductViewModel.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 5/6/24.
//

import Foundation

class ProductListViewModel: ObservableObject {
  @Published var products: [Product] = []
  @Published var errorMessage: String? = nil
    init() {
        fetchProducts{success in
        }
    }
    func fetchProducts(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:9000/api/products") else {
            completion(false)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Invalid response from server")
                    completion(false)
                    return
                }
                
                guard let data = data else {
                    print("No data received from server")
                    completion(false)
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                    self.products = decodedResponse.data
                    completion(true)
                } catch {
                    print("Error decoding JSON data: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
        dataTask.resume()
    }


}
