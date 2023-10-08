//
//  ProfileViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 11/3/2023.
//

import Foundation
import HFNavigation

extension ProfileView {
    class Model: ObservableObject {
        
        @Published public private(set) var profileUiState: UiState<HFUser> = .idle
        @Published public private(set) var historyUiState: UiState<[(Order, Barber, Barbershop)]> = .idle
        
        init() {
            self.getUser()
            self.getOrderHistory()
        }
        
        func getUser() {
            self.profileUiState = .loading
            
            guard let id = FirebaseAuth.shared.getUserId() else {
                self.profileUiState = .failed("could not find logged-in user")
                return
            }
            
            DispatchQueue.main.async {
                Task {
                    do {
                        self.profileUiState = .success(try await UserRepo.shared.getUser(id))
                    } catch {
                        self.profileUiState = .failed(error.localizedDescription)
                    }
                }
            }
        }
        
        func getOrderHistory() {
            self.historyUiState = .loading
            
            guard let id = FirebaseAuth.shared.getUserId() else {
                self.historyUiState = .failed("could not find user")
                return
            }
            
            DispatchQueue.main.async {
                Task {
                    do {
                        var result = [(Order, Barber, Barbershop)]()
                        for order in try await UserRepo.shared.getUserOrderHaistory(id) {
                            let barber = try await BarberRepo.shared.getBarber(order.barberId)
                            let barbershop = try await BarbershopRepo.shared.getBarbershop(barber.barbershopUID)
                            
                            result.append((order, barber, barbershop))
                        }
                        
                        self.historyUiState = .success(result)
                        
                    } catch {
                        self.historyUiState = .failed(error.localizedDescription)
                    }
                }
            }
        }
        
        func loggout() {
            do {
                try FirebaseAuth.shared.loggout()
                NavigationCoordinator.shared.switchStartPoint(LoginView())
            } catch {
                
            }
        }
    }
}
