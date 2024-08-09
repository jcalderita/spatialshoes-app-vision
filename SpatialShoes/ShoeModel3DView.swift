//
//  ShoeModel3DView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 8/8/24.
//

import SwiftUI
import RealityKit
import RealityShoeGallery

struct ShoeModel3DView: View {
    let shoe: ShoeModel
    
    @State private var angle: Double = 0.0
    
    var body: some View {
        Model3D(named: shoe.model3DName, bundle: realityShoeGalleryBundle) { model in
            switch model {
                case .empty:
                    CustomProgressView(title: shoe.model3DName)
                case .success(let resolvedModel3D):
                    resolvedModel3D
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(shoe.config?.scale ?? 1.0)
                        .offset(x: shoe.config?.offsetX ?? 0.0, y: shoe.config?.offsetY ?? 0.0)
//                        .offset(z: shoe.config?.offsetZ ?? 0.0)
//                        .rotation3DEffect(Angle(degrees: angle), axis: .y)
                case .failure(let error):
                    ContentUnavailableView(error.localizedDescription, systemImage: "exclamationmark.triangle.fill")
                @unknown default:
                    EmptyView()
            }
        }
        .padding()
        .task {
            print("\(shoe.model3DName): \(shoe.config?.scale ?? 0.0)")
            rotation()
        }
    }
    
    func rotation() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            angle = (angle == 360 ? 0 : angle) + 0.2
        }
        RunLoop.current.add(timer, forMode: .common)
    }
}

#Preview {
    ShoeModel3DView(shoe: ShoeModel.firstTest)
}
