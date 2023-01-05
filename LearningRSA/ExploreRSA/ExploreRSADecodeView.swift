//
//  ExploreRSADecodeView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/30/22.
//

import SwiftUI

struct ExploreRSADecodeView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    @State var encodedMessage = "123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345"
    @State var errorMessage: ErrorMessages = .noError

    @State var prime1 = "1061"
    @State var prime2 = "1531"

    @State var primeImage1 = "checkmark"
    @State var primeImage2 = "checkmark"
    let validSymbol = "checkmark"
    let invalidSymbol = "multiply"

    @State var useDifferentPrimes = false
    @State var decodedMessage = "This is a test of the decoding message system!This is a test of the decoding message system!This is a test of the decoding message system!This is a test of the decoding message system!This is a test of the decoding message system!This is a test of the decoding message system!This is a test of the decoding message system!"
    @State var showDecodedMessage = false
    
    func decodeMessage() {
        rsa.computeInvPublicKeys()
        rsa.decodeRealAndFakeMessages()
        rsa.convertDecodedMessagesToEnglish()
    }
    
    func decodeMessagePressed() {
        // Check if primes are both valid
        let validInputs = validateInputs(prime1: prime1, prime2: prime2,
                                         primeImage1: &primeImage1, primeImage2: &primeImage2,
                                         errorMessage: &errorMessage)

        if validInputs {
//            decodeMessage() // TODO: This doesn't work
            showDecodedMessage = true
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Button("Menu") {vc.currentView = .welcomeView}
                        .buttonStyle(MenuButtonStyle())
                    
                    Spacer()
                }.padding([.leading])
                                
                ErrorMessageBar(errorMessage: errorMessage)
                
                Text("Decode your message")
                    .font(.system(.title, design: .monospaced))
                
                TextInScrollView(message: encodedMessage)
                
                Group {
                    PrimeTextFieldsView(
                        prime1: $prime1, prime2: $prime2,
                        primeImage1: $primeImage1, primeImage2: $primeImage2,
                        validSymbol: validSymbol, invalidSymbol: invalidSymbol,
                        allowEditPrimes: $useDifferentPrimes
                    )

                    Button("Decode Message") {
                        decodeMessagePressed()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .font(.system(.title3, design: .monospaced))
                }

                Group {
                    DecodedMessageTextView(message: decodedMessage)
                        .opacity(showDecodedMessage ? 1.0 : 0.10)
                }

                Group {
                    HStack {
                        Button("Back to Encode") {
                            vc.currentView = .exploreRSAView
                        }
                            .buttonStyle(MenuButtonStyle())

                        Spacer()

                    }.padding([.leading, .trailing])
                }
            }.foregroundColor(.white)
        }
    }
}

struct DecodedMessageTextView: View {
    let message: String
    
    var body: some View {
        ScrollView() {
            Text(message)
                .foregroundColor(.black)
                .padding([.top, .bottom], 8)
                .padding([.leading, .trailing], 12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                )
                .font(.system(.title2, design: .monospaced, weight: .medium))
        }
    }
}

struct ExploreRSADecodeView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()
    
    static var previews: some View {
        ExploreRSADecodeView()
            .environmentObject(rsa)
            .environmentObject(vc)
    }
}
