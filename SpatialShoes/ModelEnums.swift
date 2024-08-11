//
//  ModelEnums.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 7/8/24.
//
import SwiftUI

enum ShoeType: String, Codable {
    case boots = "Botas"
    case sneakers = "Deportivas"
    case heels = "Tacones"
    case formal = "Formales"
    case casual = "Casual"
    case special = "Especiales"
    case unknown
}

enum Gender: String, Codable {
    case unisex = "Unisex"
    case male = "Masculino"
    case female = "Femenino"
    case unknown
}

enum Origin: String, Codable {
    case germany = "Alemania"
    case unitedStates = "Estados Unidos"
    case italy = "Italia"
    case japan = "Japón"
    case dragonstone = "Rocadragón"
    case spain = "España"
    case unknown
}

enum Colors: String, Codable, Identifiable {
    var id: Self { self }
    
    case black = "Negro"
    case brown = "Marrón"
    case red = "Rojo"
    case white = "Blanco"
    case unknown
    
    var color: Color {
        switch self {
            case .black:
                Color.black
            case .brown:
                Color.brown
            case .red:
                Color.red
            case .white:
                Color.white
            case .unknown:
                Color.clear
        }
    }
}

enum Certifications: String, Codable {
    case qualityCertification = "Certificación de Calidad"
    case handmade = "Hecho a mano"
    case recycledMaterials = "Materiales Reciclados"
    case ecoFriendly = "Producto Ecológico"
    case crueltyFree = "Libre de Crueldad"
    case sustainabilityCertification = "Certificación de Sostenibilidad"
    case iso9001 = "ISO 9001"
    case targaryenCertification = "Certificación Targaryen"
    case unknown
}
