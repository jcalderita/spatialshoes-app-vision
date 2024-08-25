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

struct ShoesView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @Environment(ViewModel.self) private var vm
    @Query private var shoes: [ShoeModel]
    
    @State private var scene: Entity?
    
    var body: some View {
        Group {
            if scene != .none {
                RealityView { vm.setupScene(scene, shoes: shoes, content: $0) }
                update: { vm.updateScene(scene, shoes: shoes, content: $0) }
            } else {
                CustomProgressView("Load Scene")
            }
        }
        .animation(.default, value: vm.rotationAngle)
        .task {
            await loadScene()
        }
        .onDisappear {
            resetViewModel()
        }
    }
    
    private func loadScene() async {
        scene = try? await Entity(named: GlobalData.sceneName, in: realityShoeGalleryBundle)
        vm.isImmersiveSpace = true
        openWindow(id: GlobalData.controlId)
        dismissWindow(id: GlobalData.windowId)
    }
    
    private func resetViewModel() {
        vm.selectedShoe = .none
        vm.isImmersiveSpace = false
        openWindow(id: GlobalData.windowId)
    }
}

#Preview {
    ShoesView()
        .modelContainer(ShoeModel.preview)
}
