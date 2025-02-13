//
//  Product.swift
//  Xtreme Xtends
//
//  Created by Jihad Vercher on 2/11/25.
//
// Defines structure of wig products

import Foundation

struct Product: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let price: Double
    let imageURL: String
}
