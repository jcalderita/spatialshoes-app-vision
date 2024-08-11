//
//  SizeStyleModifier.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 11/8/24.
//

import SwiftUI

struct SizeStyleModifier: ViewModifier {
    let apply: Bool
    
    func body(content: Content) -> some View {
        if apply {
            content
                .foregroundStyle(.green)
                .fontWeight(.black)
        } else {
            content
        }
    }
}

extension View {
    func sizeStyleModifier(apply: Bool) -> some View {
        self.modifier(SizeStyleModifier(apply: apply))
    }
}
