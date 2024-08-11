//
//  DetailHeaderView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 10/8/24.
//

import SwiftUI

struct DetailHeaderView: View {
    let title: String
    let isFavorite: Bool
    
    let heartFunction: () -> Void
    let exitFunction: () -> Void
    
    var body: some View {
        HStack {
            Button {
                heartFunction()
            } label: {
                Image(systemName: "heart")
                    .symbolVariant(isFavorite ? .fill : .none)
                    .foregroundStyle(isFavorite ? .red : .primary)
                    .padding()
            }
            Text(title)
                .frame(maxWidth: .infinity, alignment: .center)
            Button {
                exitFunction()
            } label: {
                Image(systemName: "multiply.circle")
                    .padding()
            }
        }
        .font(.extraLargeTitle2)
        .buttonStyle(.plain)
        .padding(.horizontal)
    }
}

//#Preview {
//    DetailHeaderView()
//}
