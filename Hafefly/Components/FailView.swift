//
//  FailView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 3/10/2023.
//

import SwiftUI

public struct FailView: View {
    
    private let errorMess: String?
    private let action: (() -> Void)?
    private var color: Color
    
    public init(errorMess: String?, action: ( () -> Void)? = nil, color: Color = .white) {
        self.errorMess = errorMess
        self.action = action
        self.color = color
    }
    
    public var body: some View {
        VStack {
            Spacer()
            Image("ic_close")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(color)
                .frame(width: 70, height: 70)
                .background(Circle().stroke(.white, lineWidth: 20).padding(10))
                .padding(.bottom)
            
            HStack {
                Text(errorMess ?? "something_went_wrong".localized)
                    .font(color, Font.HafeflyRubik.regular, 16)
                if let action = self.action {
                    Button(action: action) {
                        Text("retry".localized)
                            .font(color, .semiBold, 16)
                            .underline(true, color: color)
                    }
                }
            }
            Spacer()
        }
    }
}
