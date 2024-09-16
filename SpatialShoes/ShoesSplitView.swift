//
//  ShoesSplitView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 12/8/24.
//

import SwiftUI
import SwiftData

struct ShoesSplitView: View {
    @Query private var shoes: [ShoeModel]
    
    @State private var selectedShoe: ShoeModel?
    @State private var searchText = ""
    
    let showProgress: Bool
    
    private var filteredShoes: [ShoeModel] {
        searchText.isEmpty ? shoes : shoes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    init(favorites: Bool, showProgress: Bool) {
        self.showProgress = showProgress
        let sort = [SortDescriptor(\ShoeModel.name)]
        let filter = #Predicate<ShoeModel> { $0.isFavorite }
        _shoes = Query(filter: favorites ? filter : .none, sort: sort)
    }
    
    var body: some View {
        NavigationSplitView {
            ShoesListMenuView(shoes: filteredShoes, selectedShoe: $selectedShoe)
                .searchable(text: $searchText)
        } detail: {
            if selectedShoe != .none {
                ShoeDetail(shoe: $selectedShoe)
                    .id(selectedShoe?.name)
            } else {
                ShoesGridView(shoes: filteredShoes)
            }
        }
        .overlay {
            if showProgress {
                CustomProgressView("Load data")
            } else if filteredShoes.isEmpty && selectedShoe == .none {
                ContentUnavailableView.search
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: .resetShoeModel, object: nil, queue: .main) { _ in
                selectedShoe = nil
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self, name: .resetShoeModel, object: nil)
        }
    }
}

#Preview {
    ShoesSplitView.preview
}

#Preview("Favorites") {
    ShoesSplitView.previewWithFavorites
}

#Preview("ShowProgress") {
    ShoesSplitView.previewWithShowProgress
}
