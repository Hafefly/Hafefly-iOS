//
//  MainView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import SwiftUI

struct MainView: View {
    
    @State var tab: Tabs = .home
    
    var body: some View {
        TabView(selection: $tab) {
            ForEach(Tabs.allCases, id: \.self){ tab in
                tab.view
                    .tabItem {
                        VStack{
                            Image(tab.icon)
                                .renderingMode(.template)
                            Text(tab.rawValue)
                                .font(.white, .semiBold, 22)
                        }
                    }
            }
        }
        .onAppear {
            UITabBar.appearance().barTintColor = UIColor(Color.favoriteBlue)
        }
        .accentColor(.white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

enum Tabs: String, Hashable, CaseIterable {
    case home = "Home"
    case search = "Search"
    case map = "Map"
    case profil = "Profile"
    
    var view: AnyView {
        switch self {
        case .home: return AnyView(HomeView())
        case .search: return AnyView(SearchView())
        case .map: return AnyView(MapView())
        case .profil: return AnyView(ProfileView())
        }
    }
    
    var icon: String {
        return "ic_\(rawValue.lowercased())"
    }
}
