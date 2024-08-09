//
//  ShoeConfigModel.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 9/8/24.
//

import Foundation
import SwiftData

@Model
final class ShoeConfigModel {
    var scale: Double?
    var offsetX: Double?
    var offsetY: Double?
    var offsetZ: Double?
    var shoe: ShoeModel?
    
    init(scale: Double? = nil, offsetX: Double? = nil, offsetY: Double? = nil, offsetZ: Double? = nil, shoe: ShoeModel? = nil) {
        self.scale = scale
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.offsetZ = offsetZ
        self.shoe = shoe
    }
}
