//
//  ShoeConfigDTO.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 8/8/24.
//

import Foundation

struct ShoeConfigDTO: Decodable {
    let model3DName: String
    let scale: Double?
    let offsetX: Double?
    let offsetY: Double?
    let offsetZ: Double?
}

extension ShoeConfigDTO {
    var toShoeConfigModel: ShoeConfigModel {
        ShoeConfigModel(
            scale: scale,
            offsetX: offsetX,
            offsetY: offsetY,
            offsetZ: offsetZ
        )
    }
}
