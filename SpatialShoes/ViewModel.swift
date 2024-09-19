//
//  ViewModel.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 11/8/24.
//

import Foundation
import SwiftData
import RealityKit
import SwiftUI

@Observable
final class ViewModel {
    @MainActor static let shared = ViewModel()
    let interactor: DataInteractor
    
    var showProgress = false
    var favorites = false
    var selectedModel3DName = ""
    
    var isImmersiveSpace = false
    var rotationAngle: Float = 0.0

    var selectedShoe: ShoeModel?
    
    
    init(interactor: DataInteractor = DefaultDataInteractor()) {
        self.interactor = interactor
    }
    
    func toggleFavorites() {
        favorites.toggle()
        NotificationCenter.default.post(name: .resetShoeModel, object: nil)
    }
    
    @MainActor
    func setupScene(_ scene: Entity?, shoes: [ShoeModel], content: RealityViewContent) {
        guard let scene else { return }
        
        content.add(scene)
        shoesCircle(shoes: shoes, in: scene, content: content)
    }
    
    @MainActor
    func updateScene(_ scene: Entity?, shoes: [ShoeModel], content: RealityViewContent) {
        guard let scene else { return }
        
        scene.orientation *= simd_quatf(angle: rotationAngle, axis: [0, 1, 0])
        updatePriceVisibility(for: shoes, in: scene)
    }
    
    func selectedShoe(shoes: [ShoeModel], direction: DataMovement = .next) {
        rotationAngle = GlobalData.rotationAngle * (direction == .next ? 1 : -1)
        
        guard !shoes.isEmpty else { return }
        
        if let shoe = selectedShoe, let currentIndex = shoes.firstIndex(of: shoe) {
            let count = shoes.count
            let newIndex = direction == .next ? (currentIndex + 1) % count : (currentIndex - 1 + count) % count
            selectedShoe = shoes[newIndex]
        } else {
            selectedShoe = shoes.first
        }
    }
    
    @MainActor
    private func shoesCircle(shoes: [ShoeModel], in scene: Entity, content: RealityViewContent) {
        let count = shoes.count
        let radius: Float = 25.0

        for (index, shoe) in shoes.enumerated() {
            let angle = (Float(index) / Float(count)) * 2 * .pi
            let x = radius * cos(angle)
            let z = radius * sin(angle)

            if let shoeEntity = scene.findEntity(named: shoe.model3DName) {
                let rotation = simd_quatf(angle: .pi, axis: [0, 1, 0])
                
                shoeEntity.position = [x, 0, z]
                shoeEntity.look(at: .zero, from: shoeEntity.position, relativeTo: nil)
                shoeEntity.orientation *= rotation
                scene.addChild(shoeEntity)
                
                let priceEntity = createPriceLabelEntity(price: shoe.price)
                priceEntity.name = ("\(shoe.model3DName)price")
                priceEntity.position = [x, shoeEntity.position.y + 2.0, z]
                priceEntity.look(at: .zero, from: priceEntity.position, relativeTo: nil)
                priceEntity.orientation *= rotation
                scene.addChild(priceEntity)
            }
        }
    }
    
    @MainActor
    private func createPriceLabelEntity(price: Double) -> Entity {
        let backgroundWidth: Float = 5.0
        let backgroundHeight: Float = 1.5

        let textMesh = generatePriceText(price)
        let material = SimpleMaterial(color: .black, isMetallic: false)
        let textEntity = ModelEntity(mesh: textMesh, materials: [material])
        
        let backgroundEntity = createRoundedRectangleEntity(width: backgroundWidth, height: backgroundHeight, cornerRadius: 0.4)
        let backgroundMaterial = SimpleMaterial(color: .white, isMetallic: false)
        backgroundEntity.model?.materials = [backgroundMaterial]
        
        let textBounds = textEntity.visualBounds(relativeTo: backgroundEntity)
        let xOffset = -(textBounds.extents.x / 2.0)
        let yOffset = -(textBounds.extents.y / 2.0)
        
        textEntity.position = [xOffset, yOffset, 0.05]
        backgroundEntity.addChild(textEntity)
        
        return backgroundEntity
    }
    
    @MainActor
    private func generatePriceText(_ price: Double) -> MeshResource {
        MeshResource.generateText(
            price.formatted(.currency(code: "USD")),
            extrusionDepth: 0.0,
            font: .boldSystemFont(ofSize: 0.7),
            containerFrame: .zero,
            alignment: .center,
            lineBreakMode: .byWordWrapping
        )
    }

    @MainActor
    private func createRoundedRectangleEntity(width: Float, height: Float, cornerRadius: Float) -> ModelEntity {
        let capsule = MeshResource.generatePlane(width: width, height: height, cornerRadius: cornerRadius)
        let capsuleEntity = ModelEntity(mesh: capsule)
        
        return capsuleEntity
    }
    
    @MainActor
    private func updatePriceVisibility(for shoes: [ShoeModel], in scene: Entity) {
        for shoe in shoes {
            if let priceEntity = scene.findEntity(named: "\(shoe.model3DName)price") {
                if let selectedShoe {
                    priceEntity.isEnabled = priceEntity.name.contains(selectedShoe.model3DName)
                } else {
                    priceEntity.isEnabled = false
                }
            }
        }
    }
}
