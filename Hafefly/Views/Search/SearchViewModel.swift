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
            
            Task {
                do {
                    if text.isEmpty {
                        self.searchUiState = .success(try await BarbershopRepo.shared.listBarbershops())
                    } else {
                        #warning("implement query barbershops")
                    }
                } catch {
                    self.searchUiState = .failed(error.localizedDescription)
                }
            }
        }
    }
}
