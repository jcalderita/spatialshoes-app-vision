//
//  DetailSizeAndShoeView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 13/8/24.
//

import SwiftUI

struct DetailSizeAndShoeView: View {
    let shoe: ShoeModel
    @State private var size: Int = 0
    let sizeFunction: (Int) -> Void
    
    init(shoe: ShoeModel, sizeFunction: @escaping (Int) -> Void) {
        self.shoe = shoe
        self.sizeFunction = sizeFunction
        _size = State(initialValue: shoe.lastSize ?? 0)
    }
    
    var body: some View {
        VStack {
            DetailSizesView(shoe: shoe, sizeSelection: $size)
            DetailShoeRealityView(model3DName: shoe.model3DName, size: size == 0 ? nil : size)
        }
        .onChange(of: size) { _, newValue in
            if newValue != 0 { sizeFunction(newValue) }
        }
    }
}

#Preview {
    DetailSizeAndShoeView.preview
}
