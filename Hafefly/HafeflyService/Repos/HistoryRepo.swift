//
//  HistoryRepo.swift
//  Hafefly
//
//  Created by Samy Mehdid on 1/10/2023.
//

import Foundation

class HistoryRepo: UserRepo {
    
    static let shared = HistoryRepo(.history)
    
    func getUserHaircutHistory(userID id: String, success: @escaping ([HaircutHistory]) -> Void, failure: @escaping (String) -> Void) {
        self.queryDocuments(query: ("userID", id), success: success, failure: failure)
    }
}
