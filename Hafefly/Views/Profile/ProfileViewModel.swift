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
        @Published public private(set) var historyUiState: UiState<[HaircutHistory]> = .idle
        
        init() {
            self.getUser()
            self.getHaircutHistory()
        }
        
        func getUser() {
            self.profileUiState = .loading
            
            guard let id = FirebaseAuth.shared.getUserId() else {
                self.profileUiState = .failed("could not find logged-in user")
                return
            }
            
            UserRepo.shared.getUser(UserID: id) { user in
                self.profileUiState = .success(user)
            } failure: { error in
                self.profileUiState = .failed(error)
            }
        }
        
        func getHaircutHistory() {
            self.historyUiState = .loading
            
            guard let id = FirebaseAuth.shared.getUserId() else {
                self.historyUiState = .failed("could not find user")
                return
            }
            
//            HistoryRepo.shared.getUserHaircutHistory(userID: id) { haircutsHistory in
//                self.historyUiState = .success(haircutsHistory)
//            } failure: { error in
//                self.historyUiState = .failed(error)
//            }

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
