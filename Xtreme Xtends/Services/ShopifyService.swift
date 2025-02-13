//
//  Shopify API calls.swift
//  Xtreme Xtends
//
//  Created by Jihad Vercher on 2/11/25.
//
// Shopify API calls

import Foundation

class ShopifyService {
    static let shared = ShopifyService()
    private let baseURL = "https://your-shop.myshopify.com/api/2023-07/graphql.json"
    private let accessToken = "your_storefront_access_token"
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let query = """
        {
            products(first: 10) {
                edges {
                    node {
                        id
                        title
                        description
                        variants(first: 1) {
                            edges {
                                node {
                                    price {
                                        amount
                                    }
                                }
                            }
                        }
                        images(first: 1) {
                            edges {
                                node {
                                    url
                                }
                            }
                        }
                    }
                }
            }
        }
        """
        
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["query": query])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: 0)))
                return
            }
            
            do {
                // Parse JSON response into Product models
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                let products = try self.parseProducts(from: json ?? [:])
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    private func parseProducts(from json: [String: Any]) throws -> [Product] {
        // Implement JSON parsing here
        return []
    }
}
