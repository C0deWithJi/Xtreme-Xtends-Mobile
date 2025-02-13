// Views/ProductCard.swift
import SwiftUI

struct ProductCard: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Product Image
            AsyncImage(url: URL(string: product.imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                case .failure:
                    Image(systemName: "photo")
                        .frame(height: 200)
                default:
                    ProgressView()
                        .frame(height: 200)
                }
            }
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            // Product Title
            Text(product.title)
                .font(.headline)
                .lineLimit(1)
            
            // Price
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // Quick Add to Cart
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                // Add to cart logic
                    cart.add(product: product)
                }
            } label: {
                Text("Add to Cart")
                    .font(.caption)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .scaleEffect(cart.items.contains(where: { $0.product.id == product.id }) ? 1.1 : 1.0)
                    .animation(.spring(), value: cart.items)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}