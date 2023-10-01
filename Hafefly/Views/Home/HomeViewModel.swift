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
            getBarbershops()
        }
        
        func openCategory(_ category: Category) {
            NavigationCoordinator.pushScreen(CategoryView(category))
        }
        
        func getBarbershops() {
            barbershopsUiState = .loading
            BarbershopRepo.shared.listBarbershops { barbershops in
                let vipBarbershops = barbershops.filter{ $0.vip }
                self.barbershopsUiState = .success(vipBarbershops)
            } failure: { error in
                self.barbershopsUiState = .failed("something_went_wrong".localized)
                #warning("show error banner")
            }
        }
    }
}
