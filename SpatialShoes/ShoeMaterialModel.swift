//
//  ShoeMaterialMode.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 13/8/24.
//

import SwiftData

@Model
final class ShoeMaterialModel {
    @Attribute(.unique)
    var material: String
    var shoes: [ShoeModel]?
    
    init(_ material: String, shoes: [ShoeModel]? = .none ) {
        self.material = material
        self.shoes = shoes
    }
}
