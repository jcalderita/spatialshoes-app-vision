//
//  ShoeDetail.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 10/8/24.
//

import SwiftUI

struct ShoeDetail: View {
    @Binding var shoe: ShoeModel?
    
    var body: some View {
        if let shoe {
            VStack {
                DetailHeaderView(title: shoe.name, isFavorite: shoe.isFavorite) {
                    shoe.isFavorite.toggle()
                } exitFunction: {
                    self.shoe = .none
                }
                HStack {
                    VStack {
                        DetailSpecificationView(shoe: shoe)
                            .id(shoe.name)
                        DetailPriceView(price: shoe.price)
                            .id(shoe.name)
                    }
                    VStack {
                        Spacer()
                        DetailSizesView(shoe: shoe) { size in
                            shoe.lastSize = size
                        }
                       .id(shoe.name)
                        DetailShoeRealityView(model3DName: shoe.model3DName, size: shoe.lastSize)
                            .id("\(shoe.model3DName)\(shoe.lastSize ?? 0)")
                            .frame(maxHeight: 400)
                        DetailColorsView(colors: shoe.colors)
                        Spacer()
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ShoeDetail.preview
}

#Preview("Two") {
    ShoeDetail.preview
}
