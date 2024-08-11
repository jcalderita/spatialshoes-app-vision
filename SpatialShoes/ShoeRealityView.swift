//
//  ShoeRealityView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 9/8/24.
//

import SwiftUI
import RealityKit
import RealityShoeGallery

struct ShoeRealityView: View {
    let model3DName: String
    let size: Double? = .none
    
    @State private var shoeModel: Entity?
    @State private var angle: Double = 0.0
    @State private var timer: Timer?
    
    var body: some View {
        Group {
            if let shoeModel {
                RealityView { content in
                    shoeModel.scale = SIMD3(repeating: 0.03)
                    content.add(shoeModel)
                }
                .rotation3DEffect(Angle(degrees: angle), axis: .y)
            } else {
                CustomProgressView("Load shoe")
            }
        }
        .task {
            shoeModel = try? await Entity(named: model3DName, in: realityShoeGalleryBundle)
            rotation()
        }
        .onDisappear {
            stopRotation()
        }
    }
    
    private func rotation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            angle = (angle == 360 ? 0 : angle) + 0.2
        }
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    private func stopRotation() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    ShoeRealityView(model3DName: ShoeModel.firstTest.model3DName)
}
