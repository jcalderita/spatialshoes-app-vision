//
//  DetailPrice.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 10/8/24.
//

import SwiftUI

struct DetailPriceView: View {
    let price: Double
    let offer: Bool = Int.random(in: 0...2) == 2
    
    var body: some View {
        VStack {
            Text(offer ? "OFFER!!!": "Price")
                .font(.title)
            Text((price * (offer ? 0.25 : 1.0)).formatted(.currency(code: "USD")))
                .font(.extraLargeTitle2)
        }
        .foregroundStyle(offer ? .green : .primary)
        .padding(25)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.tertiary)
        }
    }
}

#Preview {
    NavigationStack {
        DetailPriceView(price: 99.99)
    }
}

#Preview("Two") {
    NavigationStack {
        DetailPriceView(price: 99.99)
    }
}
