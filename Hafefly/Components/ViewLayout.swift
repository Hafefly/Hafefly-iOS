//
//  ViewLayout.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/3/2023.
//

import SwiftUI

struct ViewLayout<Header: View, Content: View>: View {
    private var header: Header
    private let content: (EdgeInsets) -> Content
    
    init(@ViewBuilder header: () -> Header, @ViewBuilder content: @escaping (EdgeInsets) -> Content) {
        self.header = header()
        self.content = content
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                content(
                    EdgeInsets(
                        top: proxy.safeAreaInsets.top,
                        leading: proxy.safeAreaInsets.leading,
                        bottom: proxy.safeAreaInsets.bottom,
                        trailing: proxy.safeAreaInsets.trailing))
                .background(LinearGradient(colors: [.hafeflyBlue, .hafeflyDarkBlue], startPoint: .bottom, endPoint: .top).ignoresSafeArea())
                .setupDefaultBackHandler()
                header
            }
        }
    }
}

struct HeaderView: View {
    static let headerHeight: CGFloat = 50
    
    let title: String
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text(title)
                    .font(.white, Font.HafeflyRaisin.regular, 18)
                    .padding(.leading, 10)
                    .lineLimit(2)
                    .padding(EdgeInsets())
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .frame(height: HeaderView.headerHeight)
        .background(Color.favoriteBlue.ignoresSafeArea())
    }
    
}
