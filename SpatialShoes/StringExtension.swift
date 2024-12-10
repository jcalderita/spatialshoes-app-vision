//
//  StringExtension.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 7/8/24.
//

import Foundation

extension String {
    func nameAndExtension() throws(ResourceError) -> (name: String, ext: String) {
        let components = self.components(separatedBy: ".")
        guard components.count == 2, let name = components.first, let ext = components.last else {
            throw .invalidFormat
        }
        return (name, ext)
    }
}
