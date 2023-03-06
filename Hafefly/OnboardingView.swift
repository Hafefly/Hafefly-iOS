//
//  OnboardingView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 5/3/2023.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var step: UInt = 1
    
    var body: some View {
        VStack(spacing: 24){
            OnboardingCard(title: "Get a sick haircut", description: "new in town or trynna a new hairdresser? don’t know where to look? swipe right we got you", step: step)
                .cornerRadius(20)
            OnboardingActions($step)
                .padding(.horizontal, 16)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 46)
        .background(LinearGradient(colors: [.hafeflyBlue, .hafeflyDarkBlue], startPoint: .top, endPoint: .bottom).ignoresSafeArea())
    }
    
    
    @ViewBuilder
    private func OnboardingCard(title: String, description: String, step: UInt) -> some View{
        VStack{
            Image("onboarding\(step)")
                .resizable()
                .scaledToFit()
                .overlay(LinearGradient(colors: [Color(red: 0.35, green: 0.49, blue: 0.71), .clear], startPoint: .bottom, endPoint: .top))
            ZStack{
                Spacer()
                VStack(spacing: 100){
                    Text(title)
                        .font(.white, .semiBold, 26)
                    Text(description)
                        .font(.white, .regular, 22)
                        .multilineTextAlignment(TextAlignment.center)
                        .padding(.horizontal, 18)
                    OnboardingDots(step)
                }
            }
        }
        .background(Color.hafeflyLightBlue)
    }
    
    @ViewBuilder
    private func OnboardingActions(_ step: Binding<UInt>) -> some View {
        HStack{
            Button {
                withAnimation {
                    step.wrappedValue = 3
                }
            } label: {
                Text("skip".localized).font(.white, .medium, 18)
            }
            Spacer()
            Button {
                withAnimation {
                    step.wrappedValue += 1
                }
            } label: {
                HStack {
                    Text("next")
                        .font(.white, .medium, 18)
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                }
                
            }
        }
    }
    
    @ViewBuilder
    private func OnboardingDots(_ currentStep: UInt) -> some View {
        HStack{
            ForEach(1..<4){ step in
                RoundedRectangle(cornerRadius: .infinity)
                    .size(width: currentStep == step ? 50 : 18, height: 18)
                    .fill(Color.white)
            }
        }
        .frame(width: 180)
    }
    
}

struct OnboardingViews_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
