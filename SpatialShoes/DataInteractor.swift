//
//  DataInteractor.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 7/8/24.
//
import Foundation

protocol DataInteractor: JSONInteractor {
    static var resourceName: String { get }
    func getShoes() async throws -> [ShoeModel]
}

extension DataInteractor {
    static var resourceName: String { "shoes.json" }
    
    func getShoes() async throws -> [ShoeModel] {
        return try getDTO(resource: Self.resourceName, type: [ShoeDTO].self).map(\.toShoeModel)
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

struct DefaultDataInteractor: DataInteractor { }
