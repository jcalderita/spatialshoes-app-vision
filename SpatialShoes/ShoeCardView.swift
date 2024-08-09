//
//  ShoeCardView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 8/8/24.
//

import SwiftUI

struct ShoeCardView: View {
    let shoe: ShoeModel
    
    var body: some View {
        VStack {
            ShoeRealityView(model3DName: shoe.model3DName)
            Text(shoe.name)
                .font(.title)
                .frame(depth: 250)
        }
        .frame(width: 250, height: 300)
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ShoeCardView.preview
}
