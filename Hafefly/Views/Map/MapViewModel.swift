//
//  MapViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 10/3/2023.
//

import Foundation


extension MapView {
    class Model: ObservableObject {
        
        @Published public private(set) var mapUiState: UiState<([Barbershop])> = .idle
        
        init() {
            self.getBarbershop()
        }
        
        func getBarbershop() {
            self.mapUiState = .loading
            BarbershopRepo.shared.listBarbershops { barbershops in
                self.mapUiState = .success(barbershops)
            } failure: { error in
                self.mapUiState = .failed(error)
            }
        }
    }
}
