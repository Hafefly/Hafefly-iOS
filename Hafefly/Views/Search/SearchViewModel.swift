//
//  SearchViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 10/3/2023.
//

import Foundation

extension SearchView {
    class Model: ObservableObject {
        
        @Published var searchedBarbershops = [Barbershop]()
        
        func search(for text: String) {
            
            // assign new barbershops here
            DispatchQueue.main.async {
                // self.searchedBarbershops =
            }
        }
    }
}
