//
//  SpatialShoesApp.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 7/8/24.
//

import SwiftUI
import SwiftData

@main
struct SpatialShoesApp: App {
    @State private var vm = ViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ShoeCollectionView()
                .environment(vm)
                .modelContainer(for: [ShoeModel.self, ShoeColorModel.self], inMemory: false)
        }
        .windowResizability(.contentSize)
        
        WindowGroup(id: "volumetricShoe") {
            ShoeVolumetricView(model3DName: vm.selectedModel3DName)
        }
        .windowStyle(.volumetric)
        .defaultWindowPlacement { content, context in
            if context.windows.last?.id == "volumetricShoe" {
                WindowPlacement(.trailing(context.windows.last!))
            } else {
                WindowPlacement(.utilityPanel)
            }
        }
        .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
        .windowResizability(.contentSize)
    }
}
