//
//  ExploreRSADecodeView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/30/22.
//

import SwiftUI

struct ExploreRSADecodeView: View {
    @EnvironmentObject var rsa: RSAExplore
    
    @State var errorMessage: ErrorMessages = .noError
    
    @State var prime1 = ""
    @State var prime2 = ""

    @State var primeImage1 = "checkmark"
    @State var primeImage2 = "checkmark"

    @State var encodedMessage = ""
    @State var decodedMessage = ""
    
    @State var showDecodedMessage = false
    @State var showNextView = false
    
    @FocusState private var focusedField: FocusedField?
    
    // resets primes back to the values used with the encoding
    func resetPrimes() {
        prime1 = String(rsa.prime1)
        prime2 = String(rsa.prime2)
        
        showDecodedMessage = false
        decodedMessage = ""
    }
    
    func decodeMessage() {
        rsa.realDecodePrime1 = Int(prime1)!
        rsa.realDecodePrime2 = Int(prime2)!

        // TODO: No need to set these in the Explore section, but can't run RSA o/w
        rsa.fakeDecodePrime1 = Int(prime1)!
        rsa.fakeDecodePrime2 = Int(prime2)!
        
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
            focusedField = nil
            decodeMessage()
            decodedMessage = rsa.realDecodedMessageEng
            showDecodedMessage = true
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
                .toolbar { ExploreRSAToolbar(titleText: "Decode Message",
                                             clearInputs: resetPrimes,
                                             showDecodeButton: .constant(false),
                                             showNextView: $showNextView,
                                             encodeView: false)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()

            GeometryReader { _ in
                VStack {
                    ErrorMessageBar(errorMessage: errorMessage)
                        .padding([.top, .bottom], 5)
                    
                    Text("Your encoded message")
                        .monospacedTitleText(textStyle: .headline)
                    
                    AlternateTextInScrollView(message: encodedMessage,
                                              textColor: .white,
                                              maxHeight: .infinity)
                    .padding([.leading, .trailing, .bottom])
                    
                    PrimeTextFieldsView(
                        prime1: $prime1, prime2: $prime2,
                        primeImage1: $primeImage1, primeImage2: $primeImage2,
                        focusedField: $focusedField,
                        errorMessage: $errorMessage,
                        allowEditPrimes: .constant(true),
                        showUseDifferentPrimesCheckbox: false,
                        title: "Keep or change prime numbers", titleTextStyle: .headline
                    )
                    
                    Button("Decode Message") {
                        decodeMessagePressed()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .font(.system(.title3, design: .monospaced))
                    
                    TextInScrollView(message: decodedMessage, maxHeight: .infinity, minHeight: 0)
                        .padding()
                        .opacity(showDecodedMessage ? 1.0 : 0.10)
                        .animation(.default, value: showDecodedMessage)
                    
                }
                .monospacedBodyText()
            }
            .ignoresSafeArea(.keyboard)
        }.onAppear {
            encodedMessage = rsa.encodedMessageNum
            prime1 = String(rsa.prime1)
            prime2 = String(rsa.prime2)
        }
    }
}


struct ExploreRSADecodeView_Previews: PreviewProvider {
    @StateObject static var rsaExplore = RSAExplore()
    
    static var previews: some View {
        NavigationView {
            ExploreRSADecodeView()
                .environmentObject(rsaExplore)
        }.preferredColorScheme(.dark)
    }
}
