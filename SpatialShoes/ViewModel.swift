//
//  ViewModel.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 11/8/24.
//

import Foundation
import SwiftData

@Observable
final class ViewModel {
    static let shared = ViewModel()
    let interactor: DataInteractor
    
    var showProgress = false
    var favorites = false
    var selectedModel3DName = ""
    
    init(interactor: DataInteractor = DefaultDataInteractor()) {
        self.interactor = interactor
    }
    
    func toggleFavorites() {
        favorites.toggle()
        NotificationCenter.default.post(name: .resetShoeModel, object: nil)
    }
}
