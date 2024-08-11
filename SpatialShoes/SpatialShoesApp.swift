//
//  SpatialShoesApp.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 7/8/24.
//

import SwiftUI

@main
struct SpatialShoesApp: App {
    var body: some Scene {
        WindowGroup {
            ShoeCollectionView()
                .modelContainer(for: [ShoeModel.self, ShoeColorModel.self], inMemory: false)
        }
    }
}
