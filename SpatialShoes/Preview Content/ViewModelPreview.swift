//
//  ViewModelPreview.swift
//  SpatialShoes
//
//  Created by Jorge Calderita on 15/8/24.
//

extension ViewModel {
    @MainActor static let preview = ViewModel(interactor: PreviewDataInteractor())
}
