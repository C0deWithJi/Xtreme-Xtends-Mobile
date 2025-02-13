//
//  ProductDetailView.swift
//  Xtreme Xtends
//
//  Created by Jihad Vercher on 2/11/25.
//
// Product detail view

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @State private var selectedSize = ""
    @State private var quantity = 1

    var body: some View {
        ScrollView {
            Vstack(alignment: .leading, spacing: 16) {
                // Image Gallery
                TabView {
                    ForEach(product.images, id: \.self) { imageURL in
                        AsyncImage(url: URL(string: imageURL)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 300)

                // Product Info
                Vstack(alignment: .leading, spacing: 8) {
                    Text(product.title)
                        .font(.title)
                        .fontWeight(.bold)

                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)

                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()

                // Customization (e.g., size, quantity)
                Picker("Size", selection: $selectedSize) {
                    ForEach(product.sizes, id: \.self) { size in
                        Text(size)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                // Add to Cart
                Button {
                    //Add to cart logic
                    cart.add(product: product)
                } label: {
                    Text("Add to Cart (\(quantity))")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .scaleEffect(cart.items.contains(where: { $0.product.id == product.id }) ? 1.1 : 1.0)
                        .animation(.spring(), value: cart.items)
                }
                .padding()
            }
        }
        .navigationTitle(product.title)
    }
}

#Preview {
    ProductDetailView()
}
