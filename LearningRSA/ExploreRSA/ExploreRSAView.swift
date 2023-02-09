//
//  ExploreRSAView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/27/22.
//  Full RSA functionality on one page for exploration purposes

import SwiftUI

struct ExploreRSAToolbar: ToolbarContent {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navigationController: NavigationController
    
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
            .purpleButtonStyle()
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Help") {
                showHelpSheet = true
            }
            .sheet(isPresented: $showHelpSheet) { ExploreRSAHelpView() }
            .purpleButtonStyle()
        }
        
        ToolbarItem(placement: .principal) {
            Text(titleText)
                .monospacedTitleText()
        }

        ToolbarItemGroup(placement: .bottomBar) {
            Button(encodeView ? "Clear" : "Reset") {
                clearInputs()
            }
            .purpleButtonStyle()

            Spacer()

            if encodeView {
                Button("Decode") { showNextView = true }
                    .buttonStyle(DecodeButtonStyle(startAnimation: $showDecodeButton))
                    .opacity(showDecodeButton ? 1.0 : 0.3)
                    .animation(.default, value: showDecodeButton)
                    .disabled(!showDecodeButton)
            } else {
                Button("Menu") {
                    navigationController.popToRootFromTutorial()
                    navigationController.popToRootFromExploreRSA()
                }
                .buttonStyle(DecodeButtonStyle(startAnimation: .constant(false)))
            }

        }
    
    }
}


struct ExploreRSAView: View {
    @EnvironmentObject var rsa: RSAExplore
    
    @State var textFieldMessage = ""
    @State var inputMessage = ""
    @State var encodedMessage = ""
    @State var prime1 = ""
    @State var prime2 = ""
    @State var E = "" // encryption key exponent
    @State var M = "" // product of primes
    @State var errorMessage: ErrorMessages = .noError
        
    @State var primeImage1 = "checkmark"
    @State var primeImage2 = "checkmark"

    @State private var showEncodedMessage = false
    @State private var showNextView = false
    
    func clearInputs() {
        textFieldMessage = ""; inputMessage = ""; encodedMessage = ""
        prime1 = ""; prime2 = ""
        primeImage1 = ""; primeImage2 = ""
        E = "";
        M = ""
        errorMessage = .noError
        showEncodedMessage = false
    }
    
    func encodeMessage() {
        rsa.inputMessageEng = inputMessage
        rsa.prime1 = Int(prime1)!
        rsa.prime2 = Int(prime2)!
        
        rsa.stringToNumberConversion()
        rsa.splitInputNumberByDigits()
        rsa.computeEncryptionKeyE()
        rsa.encodeMessage()
        
        M = String(rsa.productOfPrimes)
        E = String(rsa.encryptionKeyE)
        
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
                ErrorMessageBar(errorMessage: errorMessage)
                    .padding([.top, .bottom])
                
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
                    AlternateTextInScrollView(message: encodedMessage, textColor: .white, maxHeight: 150)
                                        
                    ScrollView(.horizontal) {
                        Text("Public Key: \(E)-\(M)")
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
    @StateObject static var rsaExplore = RSAExplore()

    static var previews: some View {
        NavigationView {
            ExploreRSAView()
                .environmentObject(rsaExplore)
        }
    }
}
