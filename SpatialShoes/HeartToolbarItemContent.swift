//
//  HeartToolbarItemView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 13/8/24.
//

import SwiftUI

struct HeartToolbarItemContent: ToolbarContent {
    @Environment(\.openImmersiveSpace) private var openSpace
    
    let favorites: Bool
    let heartFunction: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .bottomOrnament) {
            HStack {
                Button {
                    heartFunction()
                } label: {
                    Image(systemName: "heart")
                        .symbolVariant(favorites ? .fill : .none)
                        .foregroundStyle(favorites ? .red : .primary)
                }
                Button {
                    Task {
                        await openSpace(id: GlobalData.immersiveId)
                    }
                } label: {
                    Image(systemName: "visionpro")
                }
            }
            .font(.extraLargeTitle)
        }
    }
}

#Preview {
    HeartToolbarItemContent.preview
}
