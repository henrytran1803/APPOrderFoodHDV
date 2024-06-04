//
//  ProductFetcher.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 12/05/2024.
//

import Foundation


class ProductFetcher: ObservableObject {
    
    @Published var products = [Product]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let service: APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
        fetchAllProducts()
    }
    
    func fetchAllProducts() {
        
        isLoading = true
        errorMessage = nil
        
        let url = URL(string: "")
        service.fetchProducts(url: url) { [unowned self] result in
            
            DispatchQueue.main.async {
                
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let products):
                    print("--- sucess with \(products.count)")
                    self.products = products
                }
            }
        }
        
    }
    static func errorState() -> ProductFetcher {
        let fetcher = ProductFetcher()
        fetcher.errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        return fetcher
    }
}
