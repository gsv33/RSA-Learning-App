//
//  ExploreRSADecodeView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/30/22.
//

import SwiftUI

struct ExploreRSADecodeView: View {
    @EnvironmentObject var rsa: RSA
    
    @State var encodedMessage = "123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345"
    @State var errorMessage: ErrorMessages = .maxMessageLength

    @State var prime1 = "1061"
    @State var prime2 = "1531"

    @State var primeImage1 = "checkmark"
    @State var primeImage2 = "checkmark"

    @State var useDifferentPrimes = false
    @State var decodedMessage = "This is a test of the decoding message system!This is a test of the decoding message system!This is a test of the decoding message system!This is a test of the decoding message system!This is a test of the decoding message system!This is a test of the decoding message system!This is a test of the decoding message system!"
    @State var showDecodedMessage = false
    @State var showNextView = false
    
    // resets primes back to the values used with the encoding
    func resetPrimes() {
        prime1 = String(rsa.prime1)
        prime2 = String(rsa.prime2)
        
        useDifferentPrimes = false
    }
    
    func decodeMessage() {
        rsa.computeDecryptionKeys()
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
                .toolbar { ExploreRSAToolbar(titleText: "Decode Message",
                                             clearInputs: {},
                                             showDecodeButton: .constant(false),
                                             showNextView: $showNextView,
                                             encodeView: false)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()

            
            
            VStack {                                
                ErrorMessageBar(errorMessage: errorMessage).padding(10)
                
                Text("Your encoded message")
                    .monospacedTitleText(textStyle: .headline)

                ScrollView() {
                    Text(encodedMessage)
                        .font(.system(.title3, design: .monospaced))
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: 150)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 3)
                ).padding([.leading, .trailing,.bottom])

                PrimeTextFieldsView(
                    prime1: $prime1, prime2: $prime2,
                    primeImage1: $primeImage1, primeImage2: $primeImage2,
                    errorMessage: $errorMessage,
                    allowEditPrimes: $useDifferentPrimes,
                    title: "Keep or change prime numbers", titleTextStyle: .headline
                )

                Button("Decode Message") {
                    decodeMessagePressed()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .font(.system(.title3, design: .monospaced))

                ScrollView() {
                    Text(decodedMessage)
                        .foregroundColor(.black)
                        .padding()
                        .font(.system(.title3, design: .monospaced))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                )
                .padding()
                .opacity(showDecodedMessage ? 1.0 : 0.10)
                .animation(.default, value: showDecodedMessage)                
            }.monospacedBodyText()
        }
    }
}


struct ExploreRSADecodeView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    
    static var previews: some View {
        NavigationView {
            ExploreRSADecodeView()
                .environmentObject(rsa)
        }
    }
}
