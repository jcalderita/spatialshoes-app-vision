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
        let filter = #Predicate<ShoeModel> { $0.isFavorite }
        _shoes = Query(filter: favorites ? filter : .none, sort: \ShoeModel.name)
    }
    
    var body: some View {
        NavigationSplitView {
            ShoesListMenuView(shoes: filteredShoes, selectedShoe: $selectedShoe)
                .searchable(text: $searchText)
        } detail: {
            detailView()
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
                Task { try await resetSelectedShoe() }
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self, name: .resetShoeModel, object: nil)
        }
    }
    
    private func resetSelectedShoe() async throws {
        self.selectedShoe = nil
    }
    private func detailView() -> some View {
        guard selectedShoe != .none else  {
            return AnyView(ShoesGridView(shoes: filteredShoes))
        }
        return AnyView(ShoeDetail(shoe: $selectedShoe)
            .id(selectedShoe?.name))
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
