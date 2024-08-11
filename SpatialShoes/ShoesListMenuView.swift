//
//  ShoesListMenuView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 10/8/24.
//

import SwiftUI

struct ShoesListMenuView: View {
    let shoes: [ShoeModel]
    @Binding var selectedShoe: ShoeModel?
    
    var body: some View {
        List {
            ForEach(shoes) { shoe in
                Button {
                    selectedShoe = shoe
                } label: {
                    Text(shoe.name)
                }
            }
        }
        .navigationTitle("Shoes")
    }
}

#Preview {
    ShoesListMenuView.preview
}
