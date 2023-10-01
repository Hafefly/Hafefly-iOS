//
//  SearchViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 10/3/2023.
//

import Foundation

extension SearchView {
    class Model: ObservableObject {
        
        @Published public private(set) var searchUiState: UiState<[Barbershop]> = .idle
        
        @Published var searchText: String = ""
        
        func search(for text: String) {
            self.searchUiState = .loading
            BarbershopRepo.shared.listBarbershops { barbershops in
                self.searchUiState = .success(barbershops)
            } failure: { error in
                self.searchUiState = .failed(error)
            }
        }
    }
}
