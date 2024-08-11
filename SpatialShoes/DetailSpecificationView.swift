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
            LabeledContent("Weight", value: shoe.weight, format: .number)
            LabeledContent("Warranty", value: shoe.warranty, format: .number)
            LabeledContent("Materials", value: shoe.materials.formatted(.list(type: .and)))
            LabeledContent("Certifications", value: shoe.certifications.formatted(.list(type: .and)))
        }
        .frame(maxHeight: 450)
        .padding()
    }
}
