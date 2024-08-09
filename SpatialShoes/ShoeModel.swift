//
//  Untitled.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 7/8/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class ShoeModel {
    @Attribute(.unique)
    var id: Int
    var name: String
    var brand: String
    var size: [Int]
    var price: Double
    var specification: String
    var model3DName: String
    var type: ShoeType
    var materials: [String]
    var origin: String
    var gender: String
    var weight: Double
    var colors: [String]
    var warranty: Int
    var certifications: [String]
    var config: ShoeConfigModel?
    var isFavorite: Bool = false
    var lastColor: String?
    var lastSize: Int?
    
    init(id: Int, name: String, brand: String, size: [Int], price: Double, specification: String, model3DName: String, type: ShoeType, materials: [String], origin: String, gender: String, weight: Double, colors: [String], warranty: Int, certifications: [String], config: ShoeConfigModel? = nil) {
        self.id = id
        self.name = name
        self.brand = brand
        self.size = size
        self.price = price
        self.specification = specification
        self.model3DName = model3DName
        self.type = type
        self.materials = materials
        self.origin = origin
        self.gender = gender
        self.weight = weight
        self.colors = colors
        self.warranty = warranty
        self.certifications = certifications
        self.config = config
    }
}

extension ShoeModel {
    @ModelActor
    actor BackgroundActor: DataInteractor {
        func importShoes() async throws {
            let shoes = try await getShoes()
            shoes.forEach {
                if let config = $0.config {
                    modelContext.delete(config)
                }
                modelContext.delete($0)
            }
            shoes.forEach { modelContext.insert($0) }
            try modelContext.save()
        }
    }
}
