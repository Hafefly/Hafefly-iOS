//
//  BarberViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/10/2023.
//

import Foundation

extension BarberView {
    class Model: ObservableObject {
        
        @Published public private(set) var reviewsUiState: UiState<[Review]> = .idle
        
        func getReviews(for id: String?) {
            self.reviewsUiState = .loading
            
            guard let id = id else {
                self.reviewsUiState = .failed("something went wrong")
                return
            }
            
            DispatchQueue.main.async {
                Task {
                    do {
                        self.reviewsUiState = .success(try await BarberRepo.shared.getBarberReviews(for: id))
                    } catch {
                        self.reviewsUiState = .failed(error.localizedDescription)
                    }
                }
            }
        }
    }
}
