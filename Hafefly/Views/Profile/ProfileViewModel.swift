//
//  ProfileViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 11/3/2023.
//

import Foundation

extension ProfileView {
    class Model: ObservableObject {
        
        @Published var profileUiState: UiState<User> = .success(.user)
        @Published var haircutsHistory: UiState<[HaircutHistory]> = .success([
//            HaircutHistory(id: 1, username: "", barber: Barbershop.barbershops[0].barbers[0], barbershop: Barbershop.barbershops[0], price: 650, time: WorkingHours(opening: Date(), closing: Date()), haircut: [.fade, .beard, .scissors]),
//            HaircutHistory(id: 1, username: "", barber: Barbershop.barbershops[1].barbers[0], barbershop: Barbershop.barbershops[0], price: 650, time: WorkingHours(opening: Date(), closing: Date()), haircut: [.fade, .beard, .scissors]),
//            HaircutHistory(id: 1, username: "", barber: Barbershop.barbershops[2].barbers[0], barbershop: Barbershop.barbershops[0], price: 650, time: WorkingHours(opening: Date(), closing: Date()), haircut: [.fade, .beard, .scissors])
        ])
        
        func getUser() {
            self.profileUiState = .loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.profileUiState = .success(User.user)
            }
        }
        
        func getHaircutHistory() {
            self.haircutsHistory = .loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.haircutsHistory = .success([])
            }
        }
    }
}
