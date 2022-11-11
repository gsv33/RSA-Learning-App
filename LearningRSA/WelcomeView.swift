//
//  WelcomeView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/8/22.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var vc: ViewCoordinator
        
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack {
                Text("Welcome to the learning RSA App!")
                    .padding()
                
                Text("This is an interactive app that will take you through the steps of encoding a message using the RSA cryptosystem.")
                    .padding()
                
                Button("Begin") {
                    vc.currentView = 1
                }
                .foregroundColor(.black)
                .buttonStyle(.borderedProminent)
                .tint(.white)
            }
            .foregroundColor(textColor)
            .bold()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()
    
    static var previews: some View {
        WelcomeView()
            .environmentObject(rsa)
            .environmentObject(vc)
    }
}
