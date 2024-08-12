//
//  DetailSizesView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 11/8/24.
//

import SwiftUI

struct DetailSizesView: View {
    let shoe: ShoeModel
    @State private var sizeSelection: Int = 0
    
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
            .onChange(of: sizeSelection) { _, newValue in
                shoe.lastSize = newValue
            }
            .task {
                sizeSelection = shoe.lastSize ?? 0
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
