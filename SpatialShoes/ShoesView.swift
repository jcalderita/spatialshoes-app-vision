//
//  ShoesView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 14/8/24.
//

import SwiftUI
import SwiftData
import RealityKit
import RealityShoeGallery
import SceneKit

struct ShoesView: View {
    @Environment(\.openWindow) private var open
    @Environment(\.dismissWindow) private var close
    
    @Environment(ViewModel.self) private var vm
    @Query private var shoes: [ShoeModel]
    @State private var scene: Entity?
    @State private var rotationUpdateTrigger = false
    
    var body: some View {
        Group {
            if let scene {
                RealityView { content in
                    content.add(scene)
                    vm.shoesCircle(shoes: shoes, in: scene, content: content)
                } update: { content in
                    scene.orientation *= simd_quatf(angle: vm.rotationAngle, axis: [0, 1, 0])
                }
            } else {
                CustomProgressView("Load Scene")
            }
        }
        .animation(.default, value: vm.rotationAngle)
        .task {
            scene = try? await Entity(named: "ShoeGallery", in: realityShoeGalleryBundle)
            vm.isImmersiveSpace = true
            open(id: GlobalData.controlId)
            close(id: GlobalData.windowId)
        }
        .onDisappear {
            vm.isImmersiveSpace = false
            open(id: GlobalData.windowId)
        }
    }
}

#Preview {
    ShoesView()
        .modelContainer(ShoeModel.preview)
}
