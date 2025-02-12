//
//  ARMeasurementService.swift
//  Xtreme Xtends
//
//  Created by Jihad Vercher on 2/11/25.
//
// AR Measurement Logic

import Foundation
import ARKit

class ARMeasurementService: NSObject, ObservableObject, ARSCNViewDelegate {
    let arView = ARSCNView()
    private let faceConfiguration = ARFaceTrackingConfiguration()
    
    @Published var crownMeasurement: Float = 0.0
    
    override init() {
        super.init()
        arView.delegate = self
        startSession()
    }
    
    func startSession() {
        guard ARFaceTrackingConfiguration.isSupported else {
            print("TrueDepth camera is not available on this device.")
            return
        }
        arView.session.run(faceConfiguration)
    }
    
    // Track facial landmarks to calculate crown size
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else { return }
        let vertices = faceAnchor.geometry.vertices
        
        // Example: Calculate distances between two key points (adjust indicies based on ARFaceAnchor)
        let point1 = vertices[10] // Top of head
        let point2 = vertices[20] // Back of head
        let distance = simd_distance(point1, point2)
        
        DispatchQueue.main.async {
            self.crownMeasurement = distance * 100 // Convert to cm
        }
    }
}
