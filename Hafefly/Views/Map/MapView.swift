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
            HafeflyMap(showUserLocation: true, barbershops: Barbershop.barbershops)
                .cornerRadius(16)
                .padding(.bottom, 16)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
