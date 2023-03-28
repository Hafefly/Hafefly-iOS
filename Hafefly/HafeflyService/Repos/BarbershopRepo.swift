//
//  BarbershopRepo.swift
//  Hafefly
//
//  Created by Samy Mehdid on 28/3/2023.
//

import Foundation

class BarbershopRepo: NetworkService {
    private enum endpoints: String {
        case listBarbershops = "/barbershops/"
        case listVIPs = "/barbershops/vip/"
        case listFavorites = "/barbershops/favorites/"
        case getBarbershop = "/barbershops/{id}/"
    }
    
    static func listBarbershops(success: @escaping ([Barbershop]) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        shared.get(endpoint: endpoints.listBarbershops.rawValue, body: [:], success: success, failure: failure)
    }
}
