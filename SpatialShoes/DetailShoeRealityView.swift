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
    @Environment(ViewModel.self) private var vm
    @Environment(\.openWindow) private var open
    
    let model3DName: String
    var size: Int?
    
    @State private var shoeModel: Entity?
    @State private var angle: Double = 0.0
    @State private var timer: Timer?
    
    var body: some View {
        detailView()
        .frame(minWidth: 300, idealWidth: 350, maxWidth: 400, minHeight: 300, idealHeight: 350, maxHeight: 400)
        .task {
            shoeModel = try? await Entity(named: model3DName, in: realityShoeGalleryBundle)
            rotation()
        }
        .onDisappear {
            stopRotation()
        }
    }
    
    private func detailView() -> some View {
        guard let shoeModel else {
            return AnyView(CustomProgressView("Load shoe"))
        }
        
        return AnyView(
            Button {
                vm.selectedModel3DName = model3DName
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
        )
    }
    
    private func rotation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            Task {
                await setAngle((self.angle + 0.2).truncatingRemainder(dividingBy: 360))
            }
        }
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    private func setAngle(_ angle: Double) async {
        self.angle = angle
    }
    
    private func stopRotation() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    DetailShoeRealityView.preview
}
