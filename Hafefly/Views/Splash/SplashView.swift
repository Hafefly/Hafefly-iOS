//
//  SplashView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import SwiftUI

struct SplashView: View {
    
    @StateObject private var model = Model()
    @StateObject private var locationManager = LocationManager.shared
    
    var body: some View {
        ViewLayout {
            //
        } content: { insets in
            switch model.uiState {
            case .loading:
                ZStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 60)
                }
            default: EmptyView()
            }
        }
        .onReceive(locationManager.$status){ status in
            if let status = status {
                model.getMe(status: status)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
