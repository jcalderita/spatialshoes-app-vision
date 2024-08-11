//
//  ShoesGridView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 10/8/24.
//

import SwiftUI

struct ShoesGridView: View {
    let shoes: [ShoeModel]
    let gridColums = [GridItem(.adaptive(minimum: 250, maximum: 300))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColums, spacing: 20.0) {
                ForEach(shoes) { shoe in
                    ShoeCardView(shoe: shoe)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ShoesGridView.preview
}
