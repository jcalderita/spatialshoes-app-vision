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
                        DetailPriceView(price: shoe.price)
                    }
                    VStack {
                        Spacer()
                        DetailSizeAndShoeView(shoe: shoe) { size in
                            shoe.lastSize = size
                        }
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
