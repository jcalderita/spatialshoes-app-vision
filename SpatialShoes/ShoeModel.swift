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
    var size: [ShoeSizeModel]
    var price: Double
    var specification: String
    var model3DName: String
    var type: ShoeType
    var materials: [ShoeMaterialModel]
    var origin: String
    var gender: String
    var weight: Double
    var colors: [ShoeColorModel]
    var warranty: Int
    var certifications: [ShoeCertificationModel]
    var isFavorite: Bool = false
    var lastColor: String?
    var lastSize: Int?
    
    init(id: Int, name: String, brand: String, size: [ShoeSizeModel], price: Double, specification: String, model3DName: String, type: ShoeType, materials: [ShoeMaterialModel], origin: String, gender: String, weight: Double, warranty: Int, certifications: [ShoeCertificationModel], colors: [ShoeColorModel]) {
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
        self.warranty = warranty
        self.certifications = certifications
        self.colors = colors
    }
}

extension ShoeModel {
    @ModelActor
    actor BackgroundActor {
        func importShoes(using interactor: DataInteractor) async throws {
            let shoes = try await interactor.getShoes()
            shoes.forEach { modelContext.insert($0) }
            try modelContext.save()
        }
    }
}
