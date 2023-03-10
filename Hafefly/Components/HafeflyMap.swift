//
//  HafeflyMap.swift
//  Hafefly
//
//  Created by Samy Mehdid on 10/3/2023.
//

import SwiftUI
import MapKit
import PopupView

struct HafeflyMap: View {
    
    @State private var barbershopSelected: Barbershop? = nil
    
    var showUserLocation: Bool = true
    
    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: LocationManager.shared.userLocation?.coordinate.latitude ?? 0, longitude: LocationManager.shared.userLocation?.coordinate.longitude ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    @State var barbershops = [Barbershop]()
    
    var body: some View {
        ZStack{
            if nil != LocationManager.shared.userLocation {
                Map(coordinateRegion: $region, showsUserLocation: showUserLocation, annotationItems: barbershops) { barbershop in
                    MapAnnotation(coordinate: barbershop.position) {
                        Image("ic_pin")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 24)
                            .foregroundColor(barbershop.vip ? .yellow : .blue)
                            .onTapGesture {
                                self.barbershopSelected = barbershop
                            }
                    }
                }
            } else {
                HafeflyButton(action: LocationManager.shared.requestLocation) {
                    Text("grant_location".localized)
                        .font(.white, Font.HafeflyRubik.regular, 18)
                }
            }
        }
        .popup(item: $barbershopSelected) { barbershop in
            BarbershopOverlay(barbershop)
                .padding(6)
        } customize: {
            $0
                .type(.floater())
                .position(.bottom)
                .dragToDismiss(true)
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.7))
        }
    }
}

struct HafeflyMap_Previews: PreviewProvider {
    static var previews: some View {
        HafeflyMap()
    }
}
