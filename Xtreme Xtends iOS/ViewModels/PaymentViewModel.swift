//
//  PaymentViewModel.swift
//  Xtreme Xtends
//
//  Created by Jihad Vercher on 2/11/25.
//
// Handles shopify integration

import Foundation
import Buy

struct CartItem {
    let variantId: GraphQL.ID
    let quantity: Int32
}

struct PaymentData {
    let cardNumber: String
    let expiryMonth: String
    let expiryYear: String
    let cvv: String
    let firstName: String
    let lastName: String
    let billingAddress: Address
    let amount: Decimal
}

// In Models/Address.swift
// In Models/Address.swift
struct Address {
    let firstName: String
    let lastName: String
    let address1: String
    let address2: String?
    let city: String
    let province: String?
    let zip: String
    let countryCode: String // e.g., "US", "CA"
}
