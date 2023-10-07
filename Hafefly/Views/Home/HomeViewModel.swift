//
//  HomeViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import Foundation
import HFNavigation

extension HomeView {
    class Model: ObservableObject {
        
        @Published public private(set) var barbershopsUiState: UiState<[Barbershop]> = .idle
        
        @Published public private(set) var favoritesBarbershopsUiState: UiState<[Barbershop]> = .idle
        @Published public private(set) var highestRatingBarbershopsUiState: UiState<[Barbershop]> = .idle
        @Published public private(set) var nearbyBarbershopsUiState: UiState<[Barbershop]> = .idle
        
        init() {
            self.getVipBarbershops()
            
            guard let userId = FirebaseAuth.shared.getUserId() else {
                return
            }
            
            self.getFavoriteBarbershops(userId)
            self.getHighestRatingsBarbershops(userId)
            self.getNearbyBarbershops(userId)
        }
        
        func getFavoriteBarbershops(_ id: String) {
            DispatchQueue.main.async {
                Task {
                    do {
                        
                        self.favoritesBarbershopsUiState = .success(try await UserRepo.shared.getUserFavoriteBarbershops(id))
                    } catch {
                        self.favoritesBarbershopsUiState = .failed("error")
                    }
                }
            }
        }
        
        func getUiState(_ category: Category) -> UiState<[Barbershop]> {
            switch category {
            case .favorites:
                return favoritesBarbershopsUiState
            case .highestRatings:
                return highestRatingBarbershopsUiState
            case .nearby:
                return nearbyBarbershopsUiState
            }
        }
        
        func getHighestRatingsBarbershops(_ id: String) {
            
        }
        
        func getNearbyBarbershops(_ id: String) {
            
        }
        
        func openCategory(_ category: Category, barbershops: [Barbershop]) {
            NavigationCoordinator.pushScreen(CategoryView(category, barbershops: barbershops))
        }
        
        func getVipBarbershops() {
            self.barbershopsUiState = .loading
            DispatchQueue.main.async {
                Task {
                    do {
                        self.barbershopsUiState = .success(try await BarbershopRepo.shared.listVipBarbershops())
                    } catch {
                        self.barbershopsUiState = .failed(error.localizedDescription)
                    }
                }
            }
        }
    }
}
