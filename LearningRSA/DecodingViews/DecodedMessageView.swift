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
    @State private var showInfoSheet = false
    @Binding var showNextView: Bool
    
    var body: some View {
        let fakePrime1 = String(rsa.fakeDecodePrime1)
        let fakePrime2 = String(rsa.fakeDecodePrime2)
        let M = String(rsa.productOfPrimes)
        let DFake = String(rsa.fakeDecryptionKeyD)
        
        VStack {
            Text("Here's your decoded message:")
                .padding()
            
            AlternateTextInScrollView(message: rsa.realDecodedMessageNum, textColor: Colors.outputColor,
                                      maxHeight: .infinity)
                .padding([.leading, .trailing, .bottom])

            Group {
                Text("And this is what you get with the fake primes and private key:")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding([.leading, .trailing])
                
                Text("Fake primes: ").padding(.top)
                Text("\(fakePrime1)").foregroundColor(Colors.lightRed) + Text(", ") +
                Text("\(fakePrime2)").foregroundColor(Colors.lightRed)
                
                Text("Fake private key: ").padding(.top)
                Text("\(DFake)")
                    .foregroundColor(Colors.lightRed) +
                Text("-") +
                Text("\(M)")
                    .foregroundColor(Colors.lightRed)
                
                Text("Fake Decoded Message:").padding(.top)
                AlternateTextInScrollView(message: rsa.fakeDecodedMessageNum, textColor: Colors.lightRed,
                                          maxHeight: .infinity)
                    .padding([.leading, .trailing])
            }
            
            MoreInfoButton(showInfoSheet: $showInfoSheet, InfoView: DecodedMessageInfoView()).padding()
            
            Button("Next") {
                rsa.convertDecodedMessagesToEnglish()
                showNextView = true
            }
            .purpleButtonStyle()
            .padding(.bottom)
        }
    }
}

struct DecodeMessageView1: View {
    @EnvironmentObject var rsa: RSA
    
    @Binding var hideView: Bool
    
    @State private var showPhiEquation = true
    @State var showDecodingDetailView = false
    @State var visitedDecodingDetailView = false
    
    var body: some View {
        VStack {
            
            Text("Now let's decode your message.").padding([.top, .leading, .trailing])
            
            DecodeEquation()
                .padding([.top, .bottom])

                
            Text("Encoded Numbers:")
            AlternateTextInScrollView(message: rsa.encodedMessageNumSplit, maxHeight: .infinity)
                .padding([.leading, .trailing, .bottom])
            
            Text("Real decryption key:")
            DisplayKeyView(exponent: rsa.realDecryptionKeyD,
                           product: rsa.productOfPrimes,
                           textStyle: .headline)
            
            Button("Show Decoding Math") {
                showDecodingDetailView = true
            }
            .sheet(isPresented: $showDecodingDetailView,
                   onDismiss: { visitedDecodingDetailView = true }) {
                EncodingDetailView(title: "Decoding Math",
                                   subtitle: "Decryption Key",
                                   exp: rsa.realDecryptionKeyD,
                                   mod: rsa.productOfPrimes,
                                   inputs: rsa.encodedMessageNumList,
                                   outputs: rsa.realDecodedMessageNumList)
                }
           .purpleButtonStyle()
           .padding()

            Group {
                Text("Decoded Numbers:")
                
                AlternateTextInScrollView(message: rsa.realDecodedMessageNumSplit, textColor: Colors.outputColor, maxHeight: .infinity)
                    .padding([.leading, .trailing])
             
                Button("Next") {
                    withAnimation(.easeIn(duration: 0.50)) {
                        hideView = true
                    }
                }
                .purpleButtonStyle()
                .padding()
            }
            .opacity(visitedDecodingDetailView ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 0.5), value: visitedDecodingDetailView)
        }
    }
}


struct DecodedMessageView: View {
    @EnvironmentObject var rsa: RSA
    
    @State var showNextView = false
    var titleText = "Message Decoding"
    
    @State private var hideView1 = false
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: NumbersToTextView(), isActive: $showNextView) {}
                .isDetailLink(false)
                .toolbar { NavigationToolbar(currentView: .decodedMessageView, titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            

            VStack {
                if !hideView1 {
                    DecodeMessageView1(hideView: $hideView1)
                }
                else {
                    DecodeMessageView2(showNextView: $showNextView)
                }
            }
            .monospacedBodyText()
        }
    }
}


struct DecodedMessageView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()

    static var previews: some View {
        NavigationView {
            DecodedMessageView()
                .environmentObject(rsa)
        }
    }
}
