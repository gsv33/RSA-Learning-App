//
//  DecodedMessageView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/2/22.
//

import SwiftUI

// Displays the final message of both the fake and real text

struct DecodedMessageView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    @State var showNextView = false
    var titleText = "Decoded Message"
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: DecodingMathView(), isActive: $showNextView) {}
                .toolbar { NavigationToolbar(titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack{
                Text("Fake message conversion!")
                
                Text(rsa.fakeDecodedMessageNum)
                Text(rsa.fakeDecodedMessageEng)
                
                Divider()
                
                Text("Real message conversion")
                Text(rsa.realDecodedMessageNum)
                Text(rsa.realDecodedMessageEng)
                
                Text("Did it work? Can you tell which is the real message and which is the fake one?").padding()
                
                Button("Play around with RSA") {
                    vc.currentView = .exploreRSAView
                }
                .buttonStyle(MenuButtonStyle())
            }
            .monospacedBodyText()
        }
    }
}


struct DecodedMessageView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        NavigationView {
            DecodedMessageView()
                .environmentObject(rsa)
                .environmentObject(vc)
        }
    }
}
