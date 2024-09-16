//
//  DetailPrice.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 10/8/24.
//

import SwiftUI

struct DetailPriceView: View {
    let price: Double
    
    var body: some View {
        VStack {
            Text("Price")
                .font(.title)
            Text(price.formatted(.currency(code: "USD")))
                .font(.extraLargeTitle2)
        }
        .padding(25)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.tertiary)
        }
    }
}

#Preview {
    DetailPriceView.preview
}
