//
//  AppointementView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/10/2023.
//

import SwiftUI
import MapKit

struct AppointementView: View {
    let barbershop: Barbershop
    
    var region: MKCoordinateRegion {
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: barbershop.coordinate.latitude, longitude: barbershop.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
    
    var body: some View {
        ViewLayout {
            congratsHeader()
        } content: { edges in
            HafeflyMap(region: region, barbershops: [barbershop])
        }
    }
    
    @ViewBuilder
    private func congratsHeader() -> some View {
        VStack{
            HStack(spacing: 18){
                Text("Congrats")
                    .font(.white, .bold, 28)
                Spacer()
                Image("saly")
                    .scaleEffect(1.8)
            }
            .padding(.horizontal)
            Text("you will soon receive a confirmation notification")
                .font(.white, .medium, 18)
                .lineLimit(1)
        }
        .padding(.vertical)
        .padding(.horizontal, 36)
        .background(Color.favoriteBlue)
        .cornerRadius(18, corners: [.bottomRight, .bottomLeft])
    }
}
