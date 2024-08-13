//
//  ShoeCertificationModel.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 13/8/24.
//

import SwiftData

@Model
final class ShoeCertificationModel {
    @Attribute(.unique)
    var certification: String
    var shoes: [ShoeModel]?
    
    init(_ certification: String, shoes: [ShoeModel]? = .none ) {
        self.certification = certification
        self.shoes = shoes
    }
}
