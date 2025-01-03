//
//  DetailSpecificationView.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 10/8/24.
//

import SwiftUI

struct DetailSpecificationView: View {
    let shoe: ShoeModel
    
    var body: some View {
        Form {
            LabeledContent("Brand", value: shoe.brand)
            LabeledContent("Type", value: shoe.type.rawValue)
            LabeledContent("Origin", value: shoe.origin)
            LabeledContent("Weight", value: "\(shoe.weight.formatted(.number)) kg")
            LabeledContent("Warranty", value: "\(shoe.warranty.formatted(.number)) years")
            LabeledContent("Materials", value: shoe.materials.map(\.material).formatted(.list(type: .and)))
            LabeledContent("Certifications", value: shoe.certifications.map(\.certification).formatted(.list(type: .and)))
        }
        .frame(maxHeight: 450)
        .padding()
    }
}
