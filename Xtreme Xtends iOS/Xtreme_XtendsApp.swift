//
//  Xtreme_XtendsApp.swift
//  Xtreme Xtends
//
//  Created by Jihad Vercher on 2/11/25.
//

import SwiftUI
import FirebaseCore



@main
struct Xtreme_XtendsApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var cart = Cart()

    var body: some Scene {
        WindowGroup {
            TabView {
                MarketplaceView()
                    .tabItem { Label("Shop", systemImage: "bag") }
                ARMeasurementView()
                    .tabItem { Label("Measure", systemImage: "camera") }
            }
            .environmentObject(cart)
        }
    }
}
