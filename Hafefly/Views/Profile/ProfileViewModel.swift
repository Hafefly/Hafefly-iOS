//
//  ProfileViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 11/3/2023.
//

import Foundation

extension ProfileView {
    class Model: ObservableObject {
        
        @Published var uiState: UiState<Barber> = .success(Barbershop.barbershops[0].barbers[0])
        
        func getUser() {
            self.uiState = .loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.uiState = .success(Barbershop.barbershops[0].barbers[0])
            }
        }
    }
}
