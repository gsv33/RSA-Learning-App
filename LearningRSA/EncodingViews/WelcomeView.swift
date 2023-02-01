//
//  WelcomeView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/8/22.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var navigationController: NavigationController
    @State private var showRSAOverview = false
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack() {
                Text("Welcome to the ")
                    .font(.system(.title, design: .monospaced))
                + Text ("Learning RSA")
                    .font(.system(.largeTitle, design: .monospaced))
                    .foregroundColor(.white)
                + Text (" App")
                    .font(.system(.title, design: .monospaced))
                
                Text("This is an interactive app that will take you through the steps of encoding a message using the RSA cryptosystem.")
                    .font(.system(.title, design: .monospaced))
                    .padding()
                    .padding(.bottom, 20)
                
                NavigationLink(
                    destination: EnterMessageView(),
                    isActive: $navigationController.tutorialNavLinkIsActive
                ) {
                    Text("Step-by-Step Walkthrough")
                }
                .isDetailLink(false)
                .buttonStyle(MenuButtonStyle(textStyle: Font.TextStyle.title2))
                .padding(.bottom, 20)
                
                NavigationLink(destination: ExploreRSAView(),
                               isActive: $navigationController.exploreNavLinkIsActive) {
                    Text("Explore RSA")
                }
                .isDetailLink(false)
                .buttonStyle(MenuButtonStyle(textStyle: Font.TextStyle.title2))
                .padding(.bottom)
                
                Button("What is RSA?") {
                    showRSAOverview = true
                }
                .sheet(isPresented: $showRSAOverview) { RSAOverviewView() }
                .foregroundColor(Colors.outputColor)
                .font(.system(.title3, design: .monospaced))
                .padding()
            }
            .bold()
        }.foregroundColor(Colors.textColor)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var navigationController = NavigationController()
    
    static var previews: some View {
        NavigationView {
            WelcomeView()
        }
        .environmentObject(rsa)
        .environmentObject(navigationController)
    }
}
