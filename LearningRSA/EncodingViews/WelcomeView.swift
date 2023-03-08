//
//  WelcomeView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/8/22.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var rsaExplore: RSAExplore
    @State private var showRSAOverview = false
    
    var body: some View {
        VStack() {
            (Text("Welcome to the ")
            + Text ("Learn RSA")
                .foregroundColor(.white)
            + Text (" App"))
            .font(.system(.title, design: .monospaced))
            .padding([.leading, .trailing])
            
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
            .purpleButtonStyle(textStyle: .title2)
            .padding(.bottom, 20)
            
            NavigationLink(destination: ExploreRSAView(),
                           isActive: $navigationController.exploreNavLinkIsActive) {
                Text("Explore RSA")
            }
            .isDetailLink(false)
            .purpleButtonStyle(textStyle: .title2)
            .padding(.bottom)
            
            Button("What is RSA?") {
                showRSAOverview = true
            }
            .sheet(isPresented: $showRSAOverview) { RSAOverviewView() }
            .foregroundColor(Colors.outputColor)
            .font(.system(.title3, design: .monospaced))
            .padding()
        }
        .fixedSize(horizontal: false, vertical: true)
        .fontWeight(.semibold)
        .foregroundColor(Colors.textColor)
        .onAppear {
            rsa.resetAllValues()
            rsaExplore.resetAllValues()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var rsaExplore = RSAExplore()
    @StateObject static var navigationController = NavigationController()
    
    static var previews: some View {
        NavigationView {
            WelcomeView()
        }
        .environmentObject(rsa)
        .environmentObject(rsaExplore)
        .environmentObject(navigationController)
        .preferredColorScheme(.dark)
    }
}
