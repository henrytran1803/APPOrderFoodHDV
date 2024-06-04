//
//  CategoryViewModel.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 4/6/24.
//

import Foundation

class CategoryListViewModel: ObservableObject {
  @Published var categories: [Category] = []
  @Published var errorMessage: String? = nil
  
  func fetchCategories() {
    guard let url = URL(string: "http://127.0.0.1:9000/api/categories") else {
      errorMessage = "Invalid API URL"
      return
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    
    let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      DispatchQueue.main.async {
        if let error = error {
          self.errorMessage = error.localizedDescription
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
          self.errorMessage = "Failed to fetch categories. Check server response."
          return
        }
        
        guard let data = data else {
          self.errorMessage = "No data received from server."
          return
        }
        
        do {
          let decodedResponse = try JSONDecoder().decode(CategoryResponse.self, from: data)
          self.categories = decodedResponse.data
        } catch {
          self.errorMessage = "Error decoding JSON data: \(error.localizedDescription)"
        }
      }
    }
    dataTask.resume()
  }
}
