//
//  DecodingMathView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/2/22.
//

import SwiftUI

struct DecodingMathView: View {
    @EnvironmentObject var rsa: RSA
    
    let titleText = "Decoding Process"
    @State var showInfoPopover = false
    @State var showNextView = false
    
    var body: some View{
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: PrivateKeyView(), isActive: $showNextView) {}
                .toolbar { NavigationToolbar(titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack {
                Text("Now, we're ready to decode your message. To do this, we use modular exponentiation, the same thing we used to encode it.")
                    .padding()
                
                Text("Remember the formula we used to encode the message, where our original message was X and our encoded message was Y?")
                    .padding([.leading, .trailing, .bottom])
                
                Text("Y = X\(UnicodeCharacters.superscriptD) mod M")
                    .font(.system(.title))
                    .foregroundColor(Colors.outputColor)
                    .padding()

                Text("To decode it, we use almost the exact same formula. The only difference is that we use a different exponent, E, instead of D. We calculate E by solving the equation: de - phi*y = 1").padding()
                
                Text("So given, an encoded message Y, we can get X back by solving: ")
                
                Text("X = Y\(UnicodeCharacters.superscriptE) mod M")
                    .font(.system(.title))
                    .foregroundColor(Colors.outputColor)
                    .padding()
                
                MoreInfoButton(
                    showInfoPopover: $showInfoPopover,
                    InfoView: DecodingMathInfoView())
                
                Button("Next") {
                    showNextView = true
                }.buttonStyle(MenuButtonStyle())
            }
            .monospacedBodyText()
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
