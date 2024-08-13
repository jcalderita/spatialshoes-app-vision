//
//  DetailSizesView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 11/8/24.
//

import SwiftUI

struct DetailSizesView: View {
    let shoe: ShoeModel
    @Binding var sizeSelection: Int
    
    var body: some View {
        Text("Available sizes")
            .font(.title)
        HStack {
            Picker("Sizes", selection: $sizeSelection) {
                ForEach(shoe.size, id: \.self) { size in
                    Text(size.formatted(.number))
                }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 350)
        }
    }
}

#Preview {
    DetailSizesView.preview
}

#Preview("Second") {
    DetailSizesView.preview
}
