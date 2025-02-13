//
//  ARMeasurementView.swift
//  Xtreme Xtends
//
//  Created by Jihad Vercher on 2/11/25.
//
// AR crown measurement view

import SwiftUI
import ARKit

struct ARMeasurementView: View {
    @StateObject private var arService = ARMeasurementService()
    
    var body: some View {
        ZStack {
            ARView(arService: arService)
            Text("Crown Size: \(String(format: "%.1f", arService.crownMeasurement)) cm")
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
        }
    }
}

struct ARView: UIViewRepresentable {
    let arService: ARMeasurementService
    
    func makeUIView(context: Context) -> ARSCNView {
        return arService.arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
}

#Preview {
    ARMeasurementView()
}
