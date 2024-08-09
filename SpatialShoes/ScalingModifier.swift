//
//  ScalingModifier.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 8/8/24.
//

import SwiftUI
import RealityKit

struct ScalingModifier<Model: Entity>: ViewModifier {
    let model: Entity
    let targetSize: Float

    func body(content: Content) -> some View {
        content
            .task {
                if let modelEntity = model as? ModelEntity {
                    let maxDimension = max(modelEntity.visualBounds(relativeTo: nil).extents.x,
                                           modelEntity.visualBounds(relativeTo: nil).extents.y,
                                           modelEntity.visualBounds(relativeTo: nil).extents.z)
                    let scale = targetSize / maxDimension
                    modelEntity.scale = SIMD3<Float>(repeating: scale)
                }
            }
    }
}

extension View {
    func scaleModel(_ model: Entity, to targetSize: Float) -> some View {
        self.modifier(ScalingModifier(model: model, targetSize: targetSize))
    }
}
