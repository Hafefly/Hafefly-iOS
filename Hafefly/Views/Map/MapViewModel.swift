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
            DispatchQueue.main.async {
                Task {
                    do {
                        self.mapUiState = .success(try await BarbershopRepo.shared.listBarbershops())
                    } catch {
                        self.mapUiState = .failed(error.localizedDescription)
                    }
                }
            }
        }
    }
}
