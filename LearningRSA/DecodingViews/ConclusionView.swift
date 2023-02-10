//
//  ConclusionView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 1/4/23.
//

import SwiftUI

struct ConclusionView: View {
    let titleText = "Next Steps"
    @State private var showExploreRSAView = false
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()

            NavigationLink(destination: ExploreRSAView(), isActive: $showExploreRSAView) {}
                .isDetailLink(false)
                .toolbar { NavigationToolbar(currentView: .conclusionView, titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack {
                Text("Well done! That's the end of the tutorial. Hopefully you've gotten a sense of what makes RSA work and why it's secure.")
                    .padding()
                
                Text("If you want, you can explore encoding and decoding more messages with RSA.")
                    .padding()

                Button("Explore RSA") {
                    showExploreRSAView = true
                }
                .purpleButtonStyle(textStyle: .title2)
                .padding()
                                                              
            }
            .monospacedTitleText()
        }
    }
}

struct ConclusionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConclusionView()
        }
    }
}
