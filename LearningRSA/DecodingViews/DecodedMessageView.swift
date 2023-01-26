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
            Text("Putting it all together, here's your decoded message:").padding()
            
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
            
            MoreInfoButton(showInfoSheet: $showInfoSheet, InfoView: DecodedMessageInfoView()).padding()
            
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
    
    @Binding var hideText: Bool
    @State var showDecodingDetailView = false
    @State var visitedDecodingDetailView = false
    
    var body: some View {
        let D = String(rsa.realDecryptionKeyD)
        let M = String(rsa.productOfPrimes)

        VStack {
            
            if !hideText {
                Text("Now we are ready to decode the message.").padding()
            }
            
            DecodeEquation()
                .padding(.bottom)

            if !hideText {
                
                Text("Encoded Message:")
                AlternateTextInScrollView(message: rsa.encodedMessageNumSplit)
                    .padding(.bottom)
                
                Text("Your decryption key:")
                Group {
                    Text("\(D)")
                        .foregroundColor(Colors.lightBlue) +
                    Text("-") +
                    Text("\(M)")
                        .foregroundColor(Colors.lightBlue)
                }
                
                Button("Show Decoding Steps") {
                    showDecodingDetailView = true
                }
                .sheet(isPresented: $showDecodingDetailView,
                       onDismiss: { visitedDecodingDetailView = true }) {
                    EncodingDetailView(title: "Decoding Math",
                                       exp: rsa.realDecryptionKeyD,
                                       mod: rsa.productOfPrimes,
                                       inputs: rsa.encodedMessageNumList,
                                       outputs: rsa.realDecodedMessageNumList)
                    }
               .buttonStyle(MenuButtonStyle())
               .padding()

                Group {
                    Text("Decooded Numbers:")
                    
                    AlternateTextInScrollView(message: rsa.realDecodedMessageNumSplit, textColor: Colors.outputColor)
                 
                    Button("Next") {
                        withAnimation(.easeIn(duration: 0.50)) {
                            hideText = true
                        }
                    }
                    .buttonStyle(MenuButtonStyle())
                    .padding()
                }
                .opacity(visitedDecodingDetailView ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.5), value: visitedDecodingDetailView)
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
                .isDetailLink(false)
                .toolbar { NavigationToolbar(currentView: .decodedMessageView, titleText: titleText) }
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

    static var previews: some View {
        NavigationView {
            DecodedMessageView()
                .environmentObject(rsa)
        }
    }
}
