//
//  ConclusionView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 1/4/23.
//

import SwiftUI

struct ConclusionView: View {
    let titleText = ""
    @State private var showNextView = false
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
                .toolbar { NavigationToolbar(titleText: titleText) }
                .navigationBarBackButtonHidden()
            // TODO: Hide Menu button!
            
            VStack {
                Text("Well done! That's the end of the tutorial. Hopefully you've gotten a sense of what makes RSA work and why it's secure.")
                    .padding()
                                
                Text("").padding()
                
                Text("If you want, you can explore encoding and decoding messages with RSA.")
                    .padding()

                Button("Explore RSA") {}
                    .buttonStyle(MenuButtonStyle())
                                                              
                Spacer()
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
