//
//  ViewModel.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 11/8/24.
//

import Foundation

@Observable
final class ViewModel {
    static let shared = ViewModel()
    
    var selectedModel3DName: String = ""
    
    private init() {}
}
