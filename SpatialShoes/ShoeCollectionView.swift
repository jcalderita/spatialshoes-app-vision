//
//  ShoeCollectionView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 7/8/24.
//

import SwiftUI
import SwiftData

struct ShoeCollectionView: View {
    @Environment(ViewModel.self) private var vm
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ShoesSplitView(favorites: vm.favorites, showProgress: vm.showProgress)
        .toolbar {
            if !vm.isImmersiveSpace {
                HeartToolbarItemContent(favorites: vm.favorites) {
                    vm.toggleFavorites()
                }
            }
        }
        .task {
            await importShoes()
        }
    }
    
    private func importShoes() async {
        vm.showProgress = true
        defer { vm.showProgress = false }
        do {
            let shoes = try await vm.interactor.getShoes()
            let bgActor = ShoeModel.BackgroundActor(modelContainer: modelContext.container)
            try await bgActor.importShoes(shoes)
        } catch {
            print(error)
        }
    }
}

#Preview("Shoe Collection") {
    ShoeCollectionView
        .preview
}
