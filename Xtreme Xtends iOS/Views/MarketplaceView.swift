//
//  MarketplaceView.swift
//  Xtreme Xtends
//
//  Created by Jihad Vercher on 2/11/25.
//
// Displays a grid/list of wigs fetched from shopify

import SwiftUI

struct MarketplaceView: View {
    @StateObject private var viewModel = MarketplaceViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(viewModel.products) { product in
                        ProductCard(product: product)
                    }
                }
                .padding()
            }
            .navigationTitle("Xtreme Xtends")
            .onAppear {
                viewModel.fetchProducts()
            }
        }
    }
}

// Simple product card
struct ProductCard: View {
    let product: Product
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.imageURL)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 150)
            
            Text(product.title)
            Text("$\(product.price, specifier: "%.2f")")
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
    }
}
