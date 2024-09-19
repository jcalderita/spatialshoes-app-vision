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
    @State private var vm = ViewModel()
    @State private var immersionStyle: ImmersionStyle = .full
    
    var body: some Scene {
        WindowGroup(id: GlobalData.windowId) {
            ShoeCollectionView()
                .animation(.default, value: vm.isImmersiveSpace)
                .environment(vm)
                .modelContainer(for: [ShoeModel.self])
                .opacity(vm.isImmersiveSpace ? 0.0 : 1.0)
        }
        .windowResizability(.contentSize)
        .persistentSystemOverlays(vm.isImmersiveSpace ? .hidden : .automatic)
        .windowStyle(.plain)
        
        WindowGroup(id: GlobalData.controlId) {
            SpaceControlView()
                .frame(minWidth: 500, minHeight: 500)
                .environment(vm)
                .modelContainer(for: [ShoeModel.self])
                .animation(.default, value: vm.isImmersiveSpace)
        }
        .defaultSize(width: 1000, height: 500)
        .windowResizability(.contentSize)
        .defaultWindowPlacement { content, context in
            WindowPlacement(.utilityPanel)
        }
        
        
        WindowGroup(id: GlobalData.volumetricId) {
            ShoeVolumetricView(model3DName: vm.selectedModel3DName)
                .opacity(vm.isImmersiveSpace ? 0.0 : 1.0)
        }
        .windowStyle(.volumetric)
        .defaultWindowPlacement { content, context in
            if context.windows.last?.id == GlobalData.volumetricId {
                WindowPlacement(.trailing(context.windows.last!))
            } else {
                WindowPlacement(.utilityPanel)
            }
        }
        .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
        .windowResizability(.contentSize)
        
        ImmersiveSpace(id: GlobalData.immersiveId) {
            SpaceView()
            ShoesView()
                .modelContainer(for: [ShoeModel.self])
                .environment(vm)
        }
        .immersionStyle(selection: $immersionStyle, in: .progressive, .full)
    }
}
