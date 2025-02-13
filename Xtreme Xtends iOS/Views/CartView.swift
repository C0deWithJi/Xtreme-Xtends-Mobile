import SwiftUI

struct CartView: View {
    @EnvironmentObject private var cart: Cart

    var body: some View {
        NavigationView {
            List {
                ForEach(cart.items) { item in 
                    HStack {
                        AsyncImage(url: URL(string: item.product.imageURL)) { image in 
                        image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)

                        VStack(alignment: .leading) {
                            Text(item.product.title)
                                .font(.headline)
                            Text("Qty: \(item.quantity)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Text("$\(item.product.price * Double(item.quantity), specifier: "%.2f")")
                            .font(.headline)
                    }
                }
                .onDelete(perform: cart.removeItems)
        
                HStack {
                    Text("Total")
                    Spacer()
                    Text("$\(cart.total, specifier: "%.2f")")
                        .fontWeight(.bold)
                }

                NAvigationLink {
                    CheckoutView(checkoutURL: URL(string: ["shopify-checkout-url"]))
                } label: {
                    Text("Checkout")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(.borderProminent)
            }
            .navigationTitle("Cart")
            .toolbar {
                EditButton()
            }
        }
    }
}