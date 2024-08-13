//
//  ShoeSizeModel.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 13/8/24.
//

import SwiftData

@Model
final class ShoeSizeModel: Comparable {
    @Attribute(.unique)
    var size: Int
    var shoes: [ShoeModel]?
    
    init(_ size: Int, shoes: [ShoeModel]? = .none ) {
        self.size = size
        self.shoes = shoes
    }
    
    static func < (lhs: ShoeSizeModel, rhs: ShoeSizeModel) -> Bool {
        lhs.size < rhs.size
    }
}
