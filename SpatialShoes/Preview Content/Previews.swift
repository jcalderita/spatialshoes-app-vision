//
//  Previews.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 7/8/24.
//

import SwiftUI

extension ShoeCollectionView {
    static var preview: some View {
        ShoeCollectionView()
            .environment(ViewModel.preview)
            .modelContainer(for: [ShoeModel.self], inMemory: true)
    }
}

extension ShoesSplitView {
    static var preview: some View {
        ShoesSplitView(favorites: false, showProgress: false)
            .modelContainer(ShoeModel.preview)
    }
    static var previewWithFavorites: some View {
        ShoesSplitView(favorites: true, showProgress: false)
            .modelContainer(ShoeModel.preview)
    }
    static var previewWithShowProgress: some View {
        ShoesSplitView(favorites: false, showProgress: true)
            .modelContainer(ShoeModel.preview)
    }
}

extension DetailShoeRealityView {
    static var preview: some View {
        DetailShoeRealityView(model3DName: ShoeModel.firstTest.model3DName)
    }
}

extension ShoeVolumetricView {
    static var preview: some View {
        ShoeVolumetricView(model3DName: ShoeModel.firstTest.model3DName)
    }
}

extension ShoesView {
    static var preview: some View {
        ShoesView()
            .modelContainer(ShoeModel.preview)
    }
}

extension ShoeCardView {
    static var preview: some View {
        ShoeCardView(shoe: ShoeModel.firstTest)
    }
}

extension ShoesGridView {
    static var preview: some View {
        NavigationStack {
            ShoesGridView(shoes: ShoeModel.shoes)
        }
    }
}

extension ShoesListMenuView {
    static var preview: some View {
        NavigationStack {
            ShoesListMenuView(shoes: ShoeModel.shoes, selectedShoe: .constant(.none))
        }
    }
}

extension ShoeDetail {
    static var preview: some View {
        NavigationStack {
            ShoeDetail(shoe: .constant(ShoeModel.firstTest))
        }
    }
}

extension DetailColorsView {
    static var preview: some View {
        NavigationStack {
            DetailColorsView(colors: ShoeModel.firstTest.colors)
        }
    }
}

extension DetailSizesView {
    static var preview: some View {
        NavigationStack {
            DetailSizesView(shoe: ShoeModel.firstTest, sizeSelection: .constant(0))
        }
    }
}

extension DetailSizeAndShoeView {
    static var preview: some View {
        NavigationStack {
            DetailSizeAndShoeView(shoe: ShoeModel.firstTest)
            { size in
                
            }
        }
    }
}

extension HeartToolbarItemContent {
    static var preview: some View {
        Text("Toolbar")
            .toolbar {
                HeartToolbarItemContent(favorites: false) {
                    print("ToolbarContent")
                }
            }
    }
}

extension DetailPriceView {
    static var preview: some View {
        NavigationStack {
            DetailPriceView(price: 99.99)
        }
    }
}
