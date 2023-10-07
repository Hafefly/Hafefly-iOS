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
                HafeflyMap()
            case .loading:
                LoadingView()
                    .frame(width: 24, height: 24)
            case .success(let barbershops):
                HafeflyMap(barbershops: barbershops)
                    .cornerRadius(16)
                    .padding(.bottom, 16)
            case .failed(let error):
                FailView(errorMess: error)
            }
            
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
