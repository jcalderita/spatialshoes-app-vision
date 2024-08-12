//
//  ShoeVolumetricView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 11/8/24.
//
import SwiftUI
import RealityKit
import RealityShoeGallery

struct ShoeVolumetricView: View {
    let model3DName: String
    
    @State private var rotation: Angle = .zero
    @State private var rotationAxis: (x: CGFloat, y: CGFloat, z: CGFloat) = (x: 0, y: 0, z: 0)
    @State private var shoeModel: Entity?
    
    @State private var currentAngleX: Float = 0.0
    @State private var currentAngleY: Float = 0.0
    
    var body: some View {
        Group {
            if let shoeModel {
                RealityView { content in
                    shoeModel.name = model3DName
                    shoeModel.scale = SIMD3(repeating: 0.03)
                    shoeModel.generateCollisionShapes(recursive: true)
                    shoeModel.components.set(InputTargetComponent())
                    content.add(shoeModel)
                }
                .gesture(DragGesture().onChanged { gesture in
                    handleRotation(value: gesture) { rotation in
                        shoeModel.transform.rotation = rotation
                    }
                })
            } else {
                CustomProgressView("Load volumetric shoe")
            }
        }
        .task {
            shoeModel = try? await Entity(named: model3DName, in: realityShoeGalleryBundle)
        }
    }
    
    private func handleRotation(value: DragGesture.Value, updateRotation: (simd_quatf) -> Void) {
        let dragAmountX = Float(value.translation.height)
        let dragAmountY = Float(value.translation.width)
        
        let angleDeltaX = dragAmountX / 500.0
        let angleDeltaY = dragAmountY / 500.0
        
        currentAngleX += angleDeltaX
        currentAngleY += angleDeltaY
        
        let rotationX = simd_quatf(angle: currentAngleX, axis: SIMD3(1, 0, 0))
        let rotationY = simd_quatf(angle: currentAngleY, axis: SIMD3(0, 1, 0))
        
        updateRotation(rotationY * rotationY)
    }
}

#Preview {
    ShoeVolumetricView(model3DName: ShoeModel.firstTest.model3DName)
}

#Preview("Two") {
    ShoeVolumetricView(model3DName: ShoeModel.firstTest.model3DName)
}
