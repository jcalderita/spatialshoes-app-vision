//
//  JSONInteractor.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 7/8/24.
//

import Foundation

protocol JSONInteractor {}

extension JSONInteractor {
    func loadJSON<T>(url: URL, type: T.Type) throws -> T where T: Decodable {
        try JSONDecoder().decode(type, from: try Data(contentsOf: url))
    }
}
