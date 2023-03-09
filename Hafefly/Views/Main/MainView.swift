//
//  MainView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import SwiftUI

struct MainView: View {
    
    @State var tab: Tabs = .home
    
    let shadowImage = UIImage.gradientImageWithBounds(
        bounds: CGRect( x: 0, y: 0, width: UIScreen.main.scale, height: 10),
        colors: [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.2).cgColor
        ]
    )
    
    var body: some View {
        TabView(selection: $tab) {
            ForEach(Tabs.allCases, id: \.self){ tab in
                ViewLayout {
                    HeaderView(title: tab == .home ? "Hafefly" : tab.rawValue.lowercased().localized)
                } content: { edges in
                    tab.view
                        .padding(.top, edges.top + 16)
                        .padding(.bottom, edges.bottom)
                        .padding(.horizontal, 16)
                }
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
            let appearance = UITabBarAppearance()
            appearance.shadowImage = shadowImage
            appearance.backgroundColor = UIColor(Color.favoriteBlue)
            UITabBar.appearance().backgroundColor = UIColor(Color.favoriteBlue)
            UITabBar.appearance().standardAppearance = appearance
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
