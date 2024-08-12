//
//  ShoeCollectionView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 7/8/24.
//

import SwiftUI
import SwiftData

struct ShoeCollectionView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showProgress = false
    @State private var favorites = false
    
    var body: some View {
        ShoesSplitView(favorites: favorites, showProgress: showProgress)
        .toolbar {
            ToolbarItem(placement: .bottomOrnament) {
                Button {
                    favorites.toggle()
                } label: {
                    Image(systemName: "heart")
                        .font(.extraLargeTitle)
                        .symbolVariant(favorites ? .fill : .none)
                        .foregroundStyle(favorites ? .red : .primary)
                }
            }
        }
        .onChange(of: favorites) {
            NotificationCenter.default.post(name: .resetShoeModel, object: nil)
        }
        .task {
            do {
                showProgress = true
                let bgActor = ShoeModel.BackgroundActor(modelContainer: modelContext.container)
                try await bgActor.importShoes()
                showProgress = false
            } catch {
                showProgress = false
                print(error)
            }
        }
    }
}

#Preview("Shoe Collection") {
    ShoeCollectionView()
        .modelContainer(ShoeModel.preview)
}
