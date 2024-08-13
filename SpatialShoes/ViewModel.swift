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
    let interactor: DataInteractor
    
    init(interactor: DataInteractor = DefaultDataInteractor()) {
        self.interactor = interactor
    }
    
    var selectedModel3DName: String = ""
}
