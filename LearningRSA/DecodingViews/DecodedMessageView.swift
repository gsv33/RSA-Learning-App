//
//  DecodedMessageView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/2/22.
//

import SwiftUI

struct DecodeMessageView2: View {
    @EnvironmentObject var rsa: RSA

    @State private var showPhiEquation = true
    @State private var showInfoPopover = false
    @Binding var showNextView: Bool
    
    var body: some View {
        let fakePrime1 = String(rsa.fakeDecodePrime1)
        let fakePrime2 = String(rsa.fakeDecodePrime2)
        let M = String(rsa.productOfPrimes)
        let DFake = String(rsa.fakeDecryptionKeyD)
        
        VStack {
            Text("Here's your decoded message:").padding()
            
            Text(rsa.realDecodedMessageNum).foregroundColor(Colors.outputColor)
                .padding([.leading, .trailing, .bottom])

            Group {
                Text("Now, using the fake primes and fake private key, here's what you would have gotten.").padding()
                
                Text("Fake primes: ")
                Text("\(fakePrime1)").foregroundColor(Colors.lightRed) + Text(", ") +
                Text("\(fakePrime2)").foregroundColor(Colors.lightRed)
                
                Text("Fake private key: ").padding(.top)
                Text("\(M)")
                    .foregroundColor(Colors.lightRed) +
                Text("-") +
                Text("\(DFake)")
                    .foregroundColor(Colors.lightRed)
                
                Text("Fake Decoded Message:").padding(.top)
                Text(rsa.fakeDecodedMessageNum).foregroundColor(Colors.lightRed)
            }
            
            MoreInfoButton(showInfoPopover: $showInfoPopover, InfoView: DecodedMessageInfoView()).padding()
            
            Button("Next") {
                rsa.convertDecodedMessagesToEnglish()
                showNextView = true
            }
            .buttonStyle(MenuButtonStyle())
        }
    }
}

struct DecodeMessageView1: View {
    @EnvironmentObject var rsa: RSA
    
    @State private var showPhiEquation = true
    @State private var showInfoPopover = false
    
    @Binding var hideText: Bool
    @State private var animationFinished = false
    
    var body: some View {
        let D = String(rsa.realDecryptionKeyD)
        let M = String(rsa.productOfPrimes)

        VStack {
            
            if !hideText {
                Text("Now we are ready to decode the message. Remember the equation we use to take an encoded message, Y, and get back the original decoded message, X.").padding()
            }
            
            DecodeEquation()
                .padding(.bottom)

            if !hideText {
                
                Text("Encoded Message: ")
                HStack {
                    ForEach(rsa.inputMessageNumList) { number in
                        Text(number.value).foregroundColor(Colors.inputColor)
                    }
                }.padding(.bottom)
                
                Text("Your private key:")
                Group {
                    Text("\(D)")
                        .foregroundColor(Colors.lightBlue) +
                    Text("-") +
                    Text("\(M)")
                        .foregroundColor(Colors.lightBlue)
                }
                
                Text("Decoding:").padding(.top)
            }
            
            EncodedMessageOutputList(
                inputs: rsa.encodedMessageNumList,
                outputs: rsa.realDecodedMessageNumList,
                exponent: D,
                modulus: M,
                animationFinished: $animationFinished,
                hideText: $hideText
            )

            if !hideText {
                Button("Next") {
                    withAnimation(.easeIn(duration: 0.50)) {
                        hideText = true
                    }
                }
                .buttonStyle(MenuButtonStyle())
                .opacity(animationFinished ? 1.0 : 0.0)
                .animation(.default, value: animationFinished)
                .padding()
            }
        }
    }
}


struct DecodedMessageView: View {
    @EnvironmentObject var rsa: RSA
    
    @State var showNextView = false
    var titleText = "Decoded Message"
    
    @State private var hideText = false
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: NumbersToTextView(), isActive: $showNextView) {}
                .toolbar { NavigationToolbar(titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack {
                DecodeMessageView1(hideText: $hideText)
                
                if hideText {
                    DecodeMessageView2(showNextView: $showNextView)
                }
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
