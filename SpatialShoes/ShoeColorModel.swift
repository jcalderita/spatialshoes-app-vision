//
//  ShoeColorModel.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 9/8/24.
//
import SwiftData

@Model
final class ShoeColorModel {
    @Attribute(.unique)
    var id: String
    var color: Colors
    var shoes: [ShoeModel]?
    
    init(id: String, color: Colors, shoes: [ShoeModel]? = .none ) {
        self.id = id
        self.color = color
        self.shoes = shoes
    }
}
