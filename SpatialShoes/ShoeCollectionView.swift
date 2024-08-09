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
    let gridColums = [GridItem(.adaptive(minimum: 250, maximum: 300))]
    @State private var searchText = ""
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(shoes) { shoe in
                    Text(shoe.name)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Shoes")
        } detail: {
            ScrollView {
                LazyVGrid(columns: gridColums) {
                    ForEach(shoes) { shoe in
                        ShoeCardView(shoe: shoe)
                    }
                }
                .padding()
            }
        }
        .overlay {
            if showProgress {
                CustomProgressView(title: "Load data")
            }
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

#Preview("Empty Collection") {
    ShoeCollectionView()
        .modelContainer(ShoeModel.preview)
}
