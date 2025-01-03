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
    
    @State private var shoeModel: Entity?
    @State private var currentRotation = simd_quatf(angle: 0, axis: SIMD3(0, 1, 0))
    
    var body: some View {
        detailView()
        .task {
            shoeModel = try? await Entity(named: model3DName, in: realityShoeGalleryBundle)
        }
    }
    
    private func rotationByGesture(_ value: DragGesture.Value) -> simd_quatf {
        simd_quatf(angle: Float(value.translation.width) / 100.0, axis: SIMD3(0, 1, 0)) * simd_quatf(angle: Float(value.translation.height) / 100.0, axis: SIMD3(1, 0, 0)) * currentRotation
    }
    
    private func detailView() -> some View {
        guard let shoeModel else {
            return AnyView(CustomProgressView("Load volumetric shoe"))
        }
        return AnyView(RealityView { content in
            shoeModel.name = model3DName
            shoeModel.scale = SIMD3(repeating: 0.03)
            shoeModel.generateCollisionShapes(recursive: true)
            shoeModel.components.set(InputTargetComponent())
            content.add(shoeModel)
        }
        .gesture(
            DragGesture()
                .onChanged { shoeModel.transform.rotation = rotationByGesture($0) }
                .onEnded{ currentRotation = rotationByGesture($0) }
        ))
    }
}

#Preview {
    ShoeVolumetricView.preview
}
