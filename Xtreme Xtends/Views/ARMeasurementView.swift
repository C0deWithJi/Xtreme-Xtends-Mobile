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
            ARViewContainer(arView: arService.arView)
            Text("Crown size: \(String(format: "%.if", arService.crownMeasurement)) cm")
                .font(.title)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    let arView: ARSCNView
    
    func makeUIView(context: Context) -> ARSCNView { arView }
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
}

#Preview {
    ARMeasurementView()
}
