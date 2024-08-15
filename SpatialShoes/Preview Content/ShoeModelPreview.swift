//
//  ShoeModelPreview.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 13/8/24.
//
import SwiftData

extension ShoeModel {
    static let firstTest = ShoeModel(
        id: 10123,
        name: "Urban Explorer",
        brand: "UrbanStride",
        size: [38, 39, 40, 41, 42].map { ShoeSizeModel($0) },
        price: 99.99,
        specification: "Descubre la combinaci\u{00f3}n perfecta entre estilo y comodidad con nuestras **Urban Explorer** de **UrbanStride**. Dise\u{00f1}adas para aquellos que buscan un calzado vers\u{00e1}til y moderno, estas botas de cuero tipo zapatillas ofrecen una apariencia robusta y sofisticada sin sacrificar el confort. Confeccionadas con cuero de alta calidad, estas botas son ideales tanto para el d\u{00ed}a a d\u{00ed}a como para ocasiones especiales.\n\n**Caracter\u{00ed}sticas Destacadas:**\n- **Material:** Cuero genuino que proporciona durabilidad y un acabado premium.\n- **Dise\u{00f1}o:** Una fusi\u{00f3}n de la cl\u{00e1}sica bota y la moderna zapatilla, perfecta para cualquier atuendo.\n- **Comodidad:** Plantilla acolchada y soporte \u{00f3}ptimo para largas jornadas.\n- **Versatilidad:** Disponible en m\u{00fa}ltiples tallas para adaptarse a todas tus necesidades.\n\nD\u{00e9}jate seducir por el estilo atemporal y la elegancia de nuestras **Urban Explorer**, y lleva tu look al siguiente nivel.",
        model3DName: "leatherShoes",
        type: ShoeType.boots,
        materials: ["Cuero"].map { ShoeMaterialModel($0) },
        origin: "Alemania",
        gender: "Unisex",
        weight: 1.2,
        warranty: 2,
        certifications: ["Certificaci\u{00f3}n de Calidad", "Hecho a mano"].map { ShoeCertificationModel($0) },
        colors: [Colors.black, Colors.brown].map { ShoeColorModel(id: $0.rawValue ,color: $0)}
    )

    static let secondTest = ShoeModel(
        id: 10234,
        name: "Retro Runner",
        brand: "EleganceWalk",
        size: [39, 40, 41, 42, 43].map { ShoeSizeModel($0) },
        price: 79.99,
        specification: "Revive el encanto del pasado con nuestras **Retro Runner** de **EleganceWalk**. Inspirados en el estilo deportivo de anta\u{00f1}o, estos zapatos deportivos retro ofrecen un dise\u{00f1}o aut\u{00e9}ntico y una comodidad excepcional. Perfectos para los amantes de la moda vintage que buscan destacarse con un toque cl\u{00e1}sico y deportivo.\n\n**Caracter\u{00ed}sticas Destacadas:**\n- **Material:** Cuero y materiales sint\u{00e9}ticos de alta calidad que garantizan durabilidad y estilo.\n- **Dise\u{00f1}o:** Aut\u{00e9}ntico estilo retro que combina funcionalidad y moda.\n- **Comodidad:** Plantilla ergon\u{00f3}mica y suela acolchada para un confort superior.\n- **Versatilidad:** Ideal para uso diario o actividades deportivas ligeras, disponibles en varias tallas.\n\nHaz una declaraci\u{00f3}n de estilo con nuestras **Retro Runner** y a\u{00f1}ade un toque vintage a tu colecci\u{00f3}n de calzado.",
        model3DName: "oldFashionSportShoes",
        type: ShoeType.sneakers,
        materials: ["Cuero"].map { ShoeMaterialModel($0) },
        origin: "Alemania",
        gender: "Unisex",
        weight: 1.2,
        warranty: 2,
        certifications: ["Certificaci\u{00f3}n de Sostenibilidad", "Hecho a mano"].map { ShoeCertificationModel($0) },
        colors: [Colors.red, Colors.white, Colors.black].map { ShoeColorModel(id: $0.rawValue ,color: $0)}
    )
    
    static let shoes = [firstTest, secondTest]
}

extension ShoeModel {
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(
            for: ShoeModel.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        container.mainContext.insert(self.firstTest)
        container.mainContext.insert(self.secondTest)
        
        return container
    }
}
