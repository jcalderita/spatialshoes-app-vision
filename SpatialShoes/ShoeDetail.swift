//
//  ShoeDetail.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 10/8/24.
//

import SwiftUI

struct ShoeDetail: View {
    @Binding var shoe: ShoeModel?
    
    var body: some View {
        if let shoe {
            VStack {
                DetailHeaderView(title: shoe.name, isFavorite: shoe.isFavorite) {
                    shoe.isFavorite.toggle()
                } exitFunction: {
                    self.shoe = .none
                }
                HStack {
                    VStack {
                        DetailSpecificationView(shoe: shoe)
                        DetailPriceView(price: shoe.price)
                    }
                    VStack {
                        Spacer()
                        Text("Available sizes")
                            .font(.title)
                        HStack {
                            ForEach(shoe.size, id: \.self) { size in
                                Button {
                                    
                                } label: {
                                    Text(size.formatted(.number))
                                }

                            }
                        }
                        ShoeRealityView(model3DName: shoe.model3DName)
                            .frame(maxHeight: 400)
                        Text("Available Colors")
                            .font(.title)
                        HStack {
                            ForEach(shoe.colors) { color in
                                Text(String.init(repeating: " ", count: 15))
                                    .padding()
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundStyle(color.color.color)
                                    }
                            }
                        }
                        .padding()
                        Spacer()
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ShoeDetail.preview
}

#Preview("Two") {
    ShoeDetail.preview
}
