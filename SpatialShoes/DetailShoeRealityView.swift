//
//  ShoeRealityView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 9/8/24.
//

import SwiftUI
import RealityKit
import RealityShoeGallery

struct DetailShoeRealityView: View {
    @Environment(\.openWindow) private var open
    
    let model3DName: String
    var size: Int?
    
    @State private var shoeModel: Entity?
    @State private var angle: Double = 0.0
    @State private var timer: Timer?
    
    var body: some View {
        Group {
            if let shoeModel {
                Button {
                    ViewModel.shared.selectedModel3DName = model3DName
                    open(id: GlobalData.volumetricId)
                } label: {
                    RealityView { content in
                        shoeModel.scale = SIMD3(repeating: 0.03 + ((Float(size ?? GlobalData.defaultSize) - Float(GlobalData.defaultSize)) * 0.002))
                        content.add(shoeModel)
                    }
                    .id("\(model3DName)\(size ?? GlobalData.defaultSize)")
                    .rotation3DEffect(Angle(degrees: angle), axis: .y)
                }
                .buttonStyle(.plain)
            } else {
                CustomProgressView("Load shoe")
            }
        }
        .frame(minWidth: 300, idealWidth: 350, maxWidth: 400, minHeight: 300, idealHeight: 350, maxHeight: 400)
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
    DetailShoeRealityView.preview
}
