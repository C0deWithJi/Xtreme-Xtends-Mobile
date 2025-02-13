import Foundation

class Cart: ObservableObject {
    @Published var items: [CartItem] = []

    // Add item to cart
    func add(product: Product, quantity: Int = 1) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += quantity
        } else {
            items.append(CartItem(product: product, quantity: quantity))
        }
    }

    // Remove item
    func remoce(atPffsets offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    // Total Price
    var total: Double {
        items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
}

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
}