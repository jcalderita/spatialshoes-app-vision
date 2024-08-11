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
    @Query(sort: \ShoeModel.model3DName) private var shoes: [ShoeModel]
    @State private var showProgress = false
    @State var selectedShoe: ShoeModel?

    @State private var searchText = ""
    private var filteredShoes: [ShoeModel] {
        if searchText.isEmpty {
            shoes
        } else {
            shoes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            ShoesListMenuView(shoes: filteredShoes, selectedShoe: $selectedShoe)
                .searchable(text: $searchText)
        } detail: {
            if selectedShoe != .none {
                ShoeDetail(shoe: $selectedShoe)
            } else {
                ShoesGridView(shoes: filteredShoes)
            }
        }
        .overlay {
            if showProgress {
                CustomProgressView("Load data")
            }
            if filteredShoes.isEmpty { ContentUnavailableView.search }
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
