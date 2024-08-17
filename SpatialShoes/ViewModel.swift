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
    static let shared = ViewModel()
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
    
    func shoesCircle(shoes: [ShoeModel], in scene: Entity, content: RealityViewContent) {
        let count = shoes.count
        let radius: Float = 25.0

        for (index, shoe) in shoes.enumerated() {
            let angle = (Float(index) / Float(count)) * 2 * .pi
            let x = radius * cos(angle)
            let z = radius * sin(angle)

            if let shoeEntity = scene.findEntity(named: shoe.model3DName) {
                shoeEntity.position = [x, 0, z]
                shoeEntity.look(at: .zero, from: shoeEntity.position, relativeTo: nil)
                let rotation = simd_quatf(angle: .pi, axis: [0, 1, 0])
                shoeEntity.orientation *= rotation
                scene.addChild(shoeEntity)
            }
        }
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
    
    func positionForSelectedShoe(in scene: Entity) -> SIMD3<Float>? {
        guard let selectedShoe = selectedShoe,
              let shoeEntity =  scene.findEntity(named: selectedShoe.model3DName) else {
            return nil
        }

        return shoeEntity.position(relativeTo: nil)
    }
}
