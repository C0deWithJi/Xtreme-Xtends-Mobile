//
//  MarketplaceViewModel.swift
//  Xtreme Xtends
//
//  Created by Jihad Vercher on 2/11/25.
//
// Business logic for products and services

import Combine
import Foundation

class MarketplaceViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let shopifyService = ShopifyService.shared
    
    func fetchProducts() {
        isLoading = true
        shopifyService.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let products):
                    self?.products = products
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }
}
