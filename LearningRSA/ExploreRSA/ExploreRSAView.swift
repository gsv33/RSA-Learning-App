//
//  ExploreRSAView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/27/22.
//  Full RSA functionality on one page for exploration purposes

import SwiftUI

struct ExploreRSAToolbar: ToolbarContent {
    @Environment(\.dismiss) var dismiss
    var titleText: String
    var clearInputs: () -> Void
    @Binding var showDecodeButton: Bool
    @Binding var showNextView: Bool
    @State private var showHelpSheet: Bool = false
    
    var encodeView = true // checks if the current view is for encoding or decoding
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Back") {
                dismiss()
            }
            .buttonStyle(BackButtonStyle())
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Help") {
                showHelpSheet = true
            }
            .sheet(isPresented: $showHelpSheet) { ExploreRSAHelpView() }
            .buttonStyle(BackButtonStyle())
        }
        
        ToolbarItem(placement: .principal) {
            Text(titleText)
                .monospacedTitleText()
        }

        ToolbarItemGroup(placement: .bottomBar) {
            Button(encodeView ? "Clear" : "Reset") {
                clearInputs()
            }
            .buttonStyle(BackButtonStyle())

            Spacer()

            if encodeView {
                Button("Decode") { showNextView = true }
                    .buttonStyle(DecodeButtonStyle(startAnimation: $showDecodeButton))
                    .opacity(showDecodeButton ? 1.0 : 0.3)
                    .animation(.default, value: showDecodeButton)
                    .disabled(!showDecodeButton)
            } else {
                Button("Menu") {}
                    .buttonStyle(DecodeButtonStyle(startAnimation: .constant(false)))
            }

        }
    
    }
}


struct ExploreRSAView: View {
    @EnvironmentObject var rsa: RSA
    
    @State var textFieldMessage = "This is a test of the vertical axis. This is a test of the vertical axis. This is a test of the vertical axis."
    @State var inputMessage = "TEST"
    @State var encodedMessage = "123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345"
    @State var prime1 = "12345"
    @State var prime2 = "12345"
    @State var k = "1234512345123451234512345123451234512345123451234512345123451234512345"
    @State var m = "12345"
    @State var errorMessage: ErrorMessages = .maxMessageLength
        
    @State var primeImage1 = "checkmark"
    @State var primeImage2 = "checkmark"

    @State private var showEncodedMessage = false
    @State private var showNextView = false
    
    func clearInputs() {
        textFieldMessage = ""; inputMessage = ""; encodedMessage = ""
        prime1 = ""; prime2 = ""
        primeImage1 = ""; primeImage2 = ""
        k = ""; m = ""
        errorMessage = .noError
        showEncodedMessage = false
    }
    
    func encodeMessage() {
        rsa.inputMessageEng = inputMessage
        
        rsa.stringToNumberConversion()
        rsa.splitInputNumberByDigits()
        rsa.computeEncryptionKeyE()
        rsa.encodeMessage()
        
        encodedMessage = rsa.encodedMessageNum
    }
        
    func encodeMessagePressed() -> Bool {
        if inputMessage.count == 0 {
            errorMessage = .noMessage
            return false
        }

        let validInputs = validateInputs(prime1: prime1, prime2: prime2,
                                         primeImage1: &primeImage1, primeImage2: &primeImage2,
                                         errorMessage: &errorMessage)
        
        if validInputs {
            encodeMessage()
            return true
        }
        
        return false
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            NavigationLink(destination: ExploreRSADecodeView(), isActive: $showNextView) {}
                .isDetailLink(false)
                .toolbar { ExploreRSAToolbar(titleText: "Encode Message",
                                             clearInputs: clearInputs,
                                             showDecodeButton: $showEncodedMessage,
                                             showNextView: $showNextView)}
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                        
            VStack {
                ErrorMessageBar(errorMessage: errorMessage).padding()
                
                Text("Enter message below")
                    .monospacedTitleText(textStyle: .headline)
                    .padding(-5)
                
                MessageFieldView(
                    textFieldMessage: $textFieldMessage,
                    inputMessage: $inputMessage,
                    errorMessage: $errorMessage,
                    textStyle: .headline,
                    maxHeight: 150
                )
                                
                PrimeTextFieldsView(
                    prime1: $prime1, prime2: $prime2,
                    primeImage1: $primeImage1, primeImage2: $primeImage2,
                    errorMessage: $errorMessage,
                    allowEditPrimes: .constant(true),
                    showUseDifferentPrimesCheckbox: false,
                    title: "Enter primes below", titleTextStyle: .headline
                )
                 
                Button("Encode Message") {
                    showEncodedMessage = encodeMessagePressed()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .font(.system(.title3, design: .monospaced))
                .padding(.bottom)
                
                Group {
                    AlternateTextInScrollView(message: encodedMessage, textColor: .white)
                                        
                    ScrollView(.horizontal) {
                        Text("Public Key: \(k) \(m)")
                    }
                }
                .opacity(showEncodedMessage ? 1.0 : 0.0)
                .animation(.default, value: showEncodedMessage)
                .padding([.leading, .trailing, .bottom])
            }
            .monospacedBodyText()
        }
    }
}
    

struct ExploreRSAView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()

    static var previews: some View {
        NavigationView {
            ExploreRSAView()
                .environmentObject(rsa)
        }
    }
}
