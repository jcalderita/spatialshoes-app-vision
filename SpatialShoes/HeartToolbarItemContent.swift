//
//  HeartToolbarItemView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 13/8/24.
//

import SwiftUI

struct HeartToolbarItemContent: ToolbarContent {
    let favorites: Bool
    let heartFunction: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .bottomOrnament) {
            Button {
                heartFunction()
            } label: {
                Image(systemName: "heart")
                    .font(.extraLargeTitle)
                    .symbolVariant(favorites ? .fill : .none)
                    .foregroundStyle(favorites ? .red : .primary)
            }
        }
    }
}

#Preview {
    HeartToolbarItemContent.preview
}
