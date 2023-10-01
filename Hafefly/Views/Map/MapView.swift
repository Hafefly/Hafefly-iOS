//
//  MapView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var model = Model()
    
    var body: some View {
        ZStack {
            switch model.mapUiState {
            case .idle:
                EmptyView()
            case .loading:
                #warning("implement loading view")
            case .success(let barbershops):
                HafeflyMap(barbershops: barbershops)
                    .cornerRadius(16)
                    .padding(.bottom, 16)
            case .failed(let string):
                #warning("implement fail view")
            }
            
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
