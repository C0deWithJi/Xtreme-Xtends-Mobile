//
//  Xtreme_XtendsApp.swift
//  Xtreme Xtends
//
//  Created by Jihad Vercher on 2/11/25.
//

import SwiftUI

@main
struct Xtreme_XtendsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                MarketplaceView()
                    .tabItem { Label("Shop", systemImage: "bag") }
                ARMeasurementView()
                    .tabItem { Label("Measure", systemImage: "camera") }
            }
        }
    }
}
