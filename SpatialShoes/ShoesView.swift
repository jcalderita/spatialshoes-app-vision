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
    
    @Environment(ViewModel.self) private var viewModel
    @Query private var shoes: [ShoeModel]
    
    @State private var scene: Entity?
    
    var body: some View {
        RealityView { content, attachments in
            setupScene(content: content, attachments: attachments)
        }
        update: { content, attachments in
            updateScene(content: content, attachments: attachments)
        }
        attachments: {
            Attachment(id: "price") { priceAttachment() }

        }
        .animation(.default, value: viewModel.rotationAngle)
        .task {
            await loadScene()
        }
        .onDisappear {
            resetViewModel()
        }
    }
    
    private func setupScene(content: RealityViewContent, attachments: RealityViewAttachments) {
        guard let scene else { return }
        
        content.add(scene)
        viewModel.shoesCircle(shoes: shoes, in: scene, content: content)
        
        if let price = attachments.entity(for: "price") {
            content.add(price)
            price.setPosition([0, -0.1, 0.2], relativeTo: scene)
        }
    }
    
    private func updateScene(content: RealityViewContent, attachments: RealityViewAttachments) {
        guard let scene else { return }
        
        scene.orientation *= simd_quatf(angle: viewModel.rotationAngle, axis: [0, 1, 0])
        
        if let position = viewModel.positionForSelectedShoe(in: scene),
           let price = attachments.entity(for: "price") {
            price.position = position
        }
    }
    
    private func priceAttachment() -> some View {
        if let selectedShoe = viewModel.selectedShoe {
            return AnyView(
                Text(selectedShoe.price.formatted(.currency(code: "USD")))
                    .padding(10)
                    .background(Circle().fill(Color.yellow))
                    .shadow(radius: 10)
            )
        } else {
            return AnyView(EmptyView())
        }
    }
    
    private func loadScene() async {
        scene = try? await Entity(named: GlobalData.sceneName, in: realityShoeGalleryBundle)
        viewModel.isImmersiveSpace = true
        openWindow(id: GlobalData.controlId)
        dismissWindow(id: GlobalData.windowId)
    }
    
    private func resetViewModel() {
        viewModel.selectedShoe = .none
        viewModel.isImmersiveSpace = false
        openWindow(id: GlobalData.windowId)
    }
}

#Preview {
    ShoesView()
        .modelContainer(ShoeModel.preview)
}
