//
//  ShoeDTO.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 7/8/24.
//
import Foundation

struct ShoeDTO: Decodable {
    let id: Int
    let name: String
    let brand: String
    let size: [Int]
    let price: Double
    let description: String
    let model3DName: String
    let type: String
    let materials: [String]
    let origin: String
    let gender: String
    let weight: Double
    let colors: [String]
    let warranty: Int
    let certifications: [String]
}

extension ShoeDTO {
    var toShoeModel: ShoeModel {
        ShoeModel(
            id: id,
            name: name,
            brand: brand,
            size: size.compactMap { ShoeSizeModel($0)},
            price: price,
            specification: description,
            model3DName: model3DName,
            type: ShoeType(rawValue: type) ?? ShoeType.unknown,
            materials: materials.compactMap { ShoeMaterialModel($0)},
            origin: origin,
            gender: gender,
            weight: weight,
            warranty: warranty,
            certifications: certifications.compactMap { ShoeCertificationModel($0) },
            colors: colors.compactMap { ShoeColorModel(id: $0 ,color: Colors(rawValue: $0) ?? Colors.unknown)}
        )
    }
}
