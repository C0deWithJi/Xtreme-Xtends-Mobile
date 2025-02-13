//
//  CheckoutView.swift
//  Xtreme Xtends
//
//  Created by Jihad Vercher on 2/11/25.
//
// Payment and shipping information

import SwiftUI
import SafariServices

struct CheckoutView: View {
    @State private var showSafari = false
    let checkoutURL: URL
    
    var body: some View {
        Button("Proceed to Payment") {
            showSafari.toggle()
        }
        .sheet(isPresented: $showSafari) {
            SafariView(url: checkoutURL)
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

