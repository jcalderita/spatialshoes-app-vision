//
//  CustomProgressView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 8/8/24.
//

import SwiftUI

struct CustomProgressView: View {
    let title: String
    
    var body: some View {
        ProgressView {
            Text(title)
        }
        .controlSize(.extraLarge)
        .font(.title)
        .fontWeight(.bold)
    }
}

#Preview {
    CustomProgressView(title: "Load data")
}
