//
//  DetailSizesView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 11/8/24.
//

import SwiftUI

struct DetailSizesView: View {
    let shoe: ShoeModel
    
    var body: some View {
        Text("Available sizes")
            .font(.title)
        HStack {
            ForEach(shoe.size, id: \.self) { size in
                Button {
                    shoe.lastSize = size == shoe.lastSize ? .none : size
                } label: {
                    Text(size.formatted(.number))
                        .sizeStyleModifier(apply: shoe.lastSize == size)
                }
            }
        }
    }
}

#Preview {
    DetailSizesView.preview
}

#Preview("Second") {
    DetailSizesView.preview
}
