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
        
        init() {
            getVipBarbershops()
        }
        
        func openCategory(_ category: Category) {
            NavigationCoordinator.pushScreen(CategoryView(category))
        }
        
        func getVipBarbershops() {
            barbershopsUiState = .loading
            BarbershopRepo.shared.listVipBarbershops { barbershops in
                self.barbershopsUiState = .success(barbershops)
            } failure: { error in
                self.barbershopsUiState = .failed("something_went_wrong".localized)
                debugPrint(error)
                #warning("show error banner")
            }
        }
    }
}
