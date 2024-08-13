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
                ForEach(shoe.size.sorted()) { sizeModel in
                    Text(sizeModel.size.formatted(.number))
                        .tag(sizeModel.size)
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
