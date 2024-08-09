//
//  DataInteractor.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 7/8/24.
//
import Foundation

protocol DataInteractor: JSONInteractor {
    func getShoes() async throws -> [ShoeModel]
}

extension DataInteractor {
    func getShoes() async throws -> [ShoeModel] {
        async let shoesDTO = try getDTO(resource: "shoes.json", type: [ShoeDTO].self)
        async let shoeConfisDTO = try getDTO(resource: "shoeConfigs.json", type: [ShoeConfigDTO].self)
        
        let (shoes, configs) = try await (shoesDTO, shoeConfisDTO)
        
        let configDict = Dictionary(grouping: configs, by: { $0.model3DName })
        
        return shoes.map { $0.toShoeModel(config: configDict[$0.model3DName]?.first?.toShoeConfigModel) }
    }
}

extension DataInteractor {
    private func getDTO<T>(resource: String, type: T.Type) throws -> T where T: Decodable {
        let resourceInfo = try resource.nameAndExtension()
        guard let url = Bundle.main.url(forResource: resourceInfo.name, withExtension: resourceInfo.ext) else {
            throw ResourceError.invalidFormat
        }
        return try loadJSON(url: url, type: type)
    }
}
