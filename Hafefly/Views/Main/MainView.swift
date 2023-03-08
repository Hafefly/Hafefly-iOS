//
//  MainView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import SwiftUI

struct MainView: View {
    
    enum Tabs: String, Hashable, CaseIterable {
        case home
        case search
        case map
        case profil
        
        var view: AnyView {
            switch self {
            case .home: return AnyView(HomeView())
            case .search: return AnyView(SearchView())
            case .map: return AnyView(MapView())
            case .profil: return AnyView(ProfileView())
            }
        }
        
        var icon: String {
            return "ic_\(rawValue)"
        }
    }
    
    @State private var tab: Tabs = .home
    
    var body: some View {
        TabView(selection: $tab) {
            ForEach(Tabs.allCases, id: \.self){ tab in
                tab.view
                    .tabItem {
                        VStack{
                            Image(tab.icon)
                            Text(tab.rawValue)
                                .font(.white, .semiBold, 22)
                        }
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
