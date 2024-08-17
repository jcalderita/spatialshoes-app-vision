//
//  SpaceView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 14/8/24.
//

import SwiftUI
import RealityKit
import SwiftData

struct SpaceView: View {
    var body: some View {
        RealityView { content in
            do {
                let resource = try await TextureResource(named: "shop")
                let material = UnlitMaterial(texture: resource)
                
                let entity = Entity()
                entity.components.set(ModelComponent(mesh: .generateSphere(radius: 100), materials: [material]))
                
                entity.scale *= [-1, 1, 1]
                
                content.add(entity)
            } catch {
                print("Error en la carga \(error)")
            }
        }
    }
}

#Preview {
    SpaceView()
}

#Preview("Second") {
    SpaceView()
}
