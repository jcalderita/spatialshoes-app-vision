//
//  SpaceControlView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 15/8/24.
//

import SwiftUI
import SwiftData

struct SpaceControlView: View {
    @Environment(ViewModel.self) private var vm
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.dismissWindow) private var dismissWindow
    
    @Query private var shoes: [ShoeModel]
    
    var body: some View {
        VStack {
            detailview()
            Spacer()
            controlButtons
                .padding(.bottom)
        }
        .onDisappear {
            dismissSpace()
        }
    }
    
    private func detailview() -> some View {
        guard let shoe = vm.selectedShoe else {
            return AnyView(
                Text(.init(GlobalData.welcome))
                .font(.headline)
                .padding()
            )
        }
        return AnyView(
            Group {
                DetailHeaderView(title: shoe.name, isFavorite: shoe.isFavorite) {
                    vm.favorites.toggle()
                } exitFunction: {
                    dismissWindow(id: GlobalData.controlId)
                }
                Text(.init(shoe.specification))
                    .font(.headline)
                    .padding()
            }
        )
    }
    
    private var controlButtons: some View {
        HStack {
            navigationButton(imageName: "chevron.left", text: "Previous") {
                vm.selectedShoe(shoes: shoes, direction: .previous)
            }
            navigationButton(imageName: "chevron.right", text: "Next") {
                vm.selectedShoe(shoes: shoes)
            }
        }
    }
    
    private func navigationButton(imageName: String, text: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                if imageName == "chevron.left" {
                    Image(systemName: imageName)
                    Text(text)
                } else {
                    Text(text)
                    Image(systemName: imageName)
                }
            }
        }
    }
    
    private func dismissSpace() {
        Task {
            vm.selectedShoe = .none
            vm.isImmersiveSpace = false
            await dismissImmersiveSpace()
        }
    }
}

#Preview {
    SpaceControlView()
}
