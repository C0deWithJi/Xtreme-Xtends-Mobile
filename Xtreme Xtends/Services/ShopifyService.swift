//
//  Shopify API calls.swift
//  Xtreme Xtends
//
//  Created by Jihad Vercher on 2/11/25.
//
// Shopify API calls

import Foundation
import Buy

class ShopifyService {
    static let shared = ShopifyService()
    private let client: Graph.Client
    
    init() {
        client = Graph.Client(shopDomain: Constants.shopDomain, apiKey: Constants.apiKey)
    }
}
