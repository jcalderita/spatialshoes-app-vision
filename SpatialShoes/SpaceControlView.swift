//
//  SpaceControlView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 15/8/24.
//

import SwiftUI

struct SpaceControlView: View {
    @Environment(ViewModel.self) private var vm
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    Task {
                        await dismissImmersiveSpace()
                    }
                } label: {
                    Image(systemName: "multiply.circle")
                        .font(.extraLargeTitle2)
                        .padding()
                }
                .buttonStyle(.plain)
            }
            HStack {
                Button {
                    vm.rotationAngle = -0.30
                } label: {
                    Label("Previous", systemImage: "chevron.left")
                }
                Spacer()
                Button {
                    vm.rotationAngle = 0.30
                } label: {
                    Label("Next", systemImage: "chevron.right")
                }
            }
        }
    }
}

#Preview {
    SpaceControlView()
}
