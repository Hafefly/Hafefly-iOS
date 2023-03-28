//
//  HomeViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import Foundation

extension HomeView {
    class Model: ObservableObject {
        
        @Published var barbershopsUiState: UiState<[Barbershop]> = .idle
        
        init() {
            getBarbershops()
        }
        
        func openCategory(_ category: Category) {
            NavigationCoordinator.pushScreen(.category(category))
        }
        
        func getBarbershops() {
            barbershopsUiState = .loading
            BarbershopRepo.listBarbershops { barbershops in
                self.barbershopsUiState = .success(barbershops)
            } failure: { error in
                self.barbershopsUiState = .failed("something_went_wrong".localized)
                #warning("show error banner")
            }

        }
    }
}
