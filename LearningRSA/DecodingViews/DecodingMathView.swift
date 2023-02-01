//
//  DecodingMathView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/2/22.
//

import SwiftUI

struct DecodingMathView: View {
    @EnvironmentObject var rsa: RSA
    
    let titleText = "Decoding Equation"
    @State var showInfoSheet = false
    @State var showNextView = false
    
    @State var viewOpacity = 0.0
    
    var body: some View{
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: PrivateKeyView(), isActive: $showNextView) {}
                .isDetailLink(false)
                .toolbar { NavigationToolbar(currentView: .decodingMathView, titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        Text("Now, we're ready to decode your message. To do this, we use modular exponentiation, the same thing we used to encode it.")
                            .padding()
                        
                        Text("Remember the formula we used to encode the message, where our original message was X?")
                            .padding([.leading, .trailing])
                        
                        EncodeEquation().padding()
                        
                        Text("To decode it, we use almost the exact same formula. The only difference is that we use a different exponent, D, instead of E.")
                            .padding([.leading, .trailing, .bottom])
                        
                        Text("So given, an encoded message Y, we can get X back by solving: ").padding([.leading, .trailing])
                        
                        DecodeEquation().padding()
                        
                        MoreInfoButton(
                            showInfoSheet: $showInfoSheet,
                            InfoView: DecodingMathInfoView())
                        
                        Button("Next") {
                            showNextView = true
                        }.buttonStyle(MenuButtonStyle())
                            .padding([.top, .bottom])
                    }
                    .frame(minHeight: geometry.size.height)
                    .onAppear {viewOpacity = 1.0 }
                    .opacity(viewOpacity)
                    .animation(.easeIn(duration: 1.0), value: viewOpacity)
                    .monospacedBodyText()
                }
            }
        }
    }
}

struct DecodingMathView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()

    static var previews: some View {
        
        NavigationView {
            DecodingMathView()
                .environmentObject(rsa)
        }
    }
}
