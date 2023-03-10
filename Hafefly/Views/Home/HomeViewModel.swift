//
//  HomeViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import Foundation

extension HomeView {
    class Model: ObservableObject {
        
        func openCategory(_ category: Category) {
            NavigationCoordinator.pushScreen(.category(category))
        }
    }
}
