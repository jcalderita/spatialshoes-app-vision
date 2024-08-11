//
//  DetailColorsView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 11/8/24.
//

import SwiftUI

struct DetailColorsView: View {
    let colors: [ShoeColorModel]
    
    var body: some View {
        Text("Available Colors")
            .font(.title)
        HStack {
            ForEach(colors) { color in
                Text(String.init(repeating: " ", count: 15))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(color.color.color)
                    }
            }
        }
        .padding()
    }
}

#Preview {
    DetailColorsView.preview
}
