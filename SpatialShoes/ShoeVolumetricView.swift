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
    
    var body: some View {
        Group {
            Text(model3DName)
            if let shoeModel {
                RealityView { content in
                    shoeModel.name = model3DName
                    shoeModel.scale = SIMD3(repeating: 0.03)
                    shoeModel.generateCollisionShapes(recursive: false)
                    shoeModel.components.set(InputTargetComponent())
                    content.add(shoeModel)
                }
                .gesture(
                    DragGesture()
                        .targetedToAnyEntity()
                        .onChanged { value in
                            print(value)
                            let angle = sqrt(pow(value.translation.width, 2) + pow(value.translation.height, 2))
                            rotation = Angle(degrees: Double(angle))
                            
                            let axisX = -value.translation.height / CGFloat(angle)
                            let axisY = value.translation.width / CGFloat(angle)
                            rotationAxis = (x: axisX, y: axisY, z: 0)
                        }
                )
//                .rotation3DEffect(rotation, axis: rotationAxis)
            }
        }
        .task {
            shoeModel = try? await Entity(named: model3DName, in: realityShoeGalleryBundle)
        }
    }
}

#Preview {
    ShoeVolumetricView(model3DName: ShoeModel.firstTest.model3DName)
//        .WindowStyle(.volumetric)
}
