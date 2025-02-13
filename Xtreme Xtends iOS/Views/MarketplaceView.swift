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
    @State private var serachText = ""

    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 160), GridItem(.adaptive(minimum: 160))]
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.filteredProducts) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductCard(product: product)
                                .onAppear {
                                    if product == viewModel.filteredProducts.last {
                                        viewModel.loadMoreProducts()
                                    }
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()

                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.filteredProducts.isEmpty {
                    Text("No products found")
                        .foregroundColor(.systemGray6)
                        .padding()
                }
            }
            .navigationTitle("Xtreme Xtends")
            .searchable(text: $searchText, prompt: "Search products...")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    FilterSortButton(viewModel: viewModel)
                }
            }
            .onChange(of: searchText) { newValue in
                viewModel.searchText = newValue
            }
        }
    }
}

