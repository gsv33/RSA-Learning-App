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
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Back") {
                dismiss()
            }
            .buttonStyle(BackButtonStyle())
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Help") {
                // TODO: disimss all views and go back to the Menu
            }
            .buttonStyle(BackButtonStyle())
        }
        
        ToolbarItem(placement: .principal) {
            Text(titleText)
                .monospacedTitleText()
        }
        
        ToolbarItemGroup(placement: .bottomBar) {
            Button("Clear") {
//                clearInputs()
                
            }
                .buttonStyle(BackButtonStyle())
            Spacer()
//            DecodeButtonView(
//                startAnimation: .constant(false) //TODO: Need to update
//            )
        }
    }
}


struct ExploreRSAView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    @State var textFieldMessage = "This is a test of the vertical axis. This is a test of the vertical axis. This is a test of the vertical axis."
    @State var inputMessage = "TEST"
    @State var encodedMessage = "123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345"
    @State var prime1 = "12345"
    @State var prime2 = "12345"
    @State var k = "1234512345123451234512345123451234512345123451234512345123451234512345"
    @State var m = "12345"
    @State var errorMessage: ErrorMessages = .maxMessageLength
    
    let maxCharsInMessage = 200
    
    @State var primeImage1 = "checkmark"
    @State var primeImage2 = "checkmark"
    let validSymbol = "checkmark"
    let invalidSymbol = "multiply"
    
    @State var currentView = 1

    @State var startDecodeButtonAnimation = false
    
    func clearInputs() {
        textFieldMessage = ""
        inputMessage = ""
        encodedMessage = ""
        prime1 = ""
        prime2 = ""
        primeImage1 = ""
        primeImage2 = ""
        k = ""
        m = ""
        errorMessage = .noError
        startDecodeButtonAnimation = false
    }
    
    func encodeMessage() {
        rsa.inputMessageEng = inputMessage
        rsa.stringToNumberConversion()
        rsa.computeProductOfPrimes()
        rsa.splitInputNumberByDigits()
        try! rsa.computePublicKeyK()
        k = String(rsa.publicKeyK)
        rsa.encodeMessage()
        encodedMessage = rsa.encodedMessageNum
    }
        
    func encodeMessagePressed() {
        if inputMessage.count == 0 {
            errorMessage = .noMessage
            return
        }

        let validInputs = validateInputs(prime1: prime1, prime2: prime2,
                                         primeImage1: &primeImage1, primeImage2: &primeImage2,
                                         errorMessage: &errorMessage)
        
        if validInputs {
            encodeMessage()
            startDecodeButtonAnimation = true
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
                .toolbar { ExploreRSAToolbar(titleText: "Encode Message") }
                .navigationBarTitleDisplayMode(.inline)
                        
            VStack {
                ErrorMessageBar(errorMessage: errorMessage).padding()
                
                if currentView == 1 {
                    Text("Enter message below")
                        .monospacedTitleText(textStyle: .headline)
                }
                
                MessageFieldView(
                    textFieldMessage: $textFieldMessage,
                    inputMessage: $inputMessage,
                    errorMessage: $errorMessage,
                    maxCharsInMessage: maxCharsInMessage
                )
                .frame(maxHeight: .infinity)
                .foregroundColor(.black)
                
                if currentView == 1 {
                    Button("Enter Primes") {
                        currentView = 2
                    }
                        .buttonStyle(MenuButtonStyle())
                }
                
                Group {
                    PrimeTextFieldsView(
                        prime1: $prime1, prime2: $prime2,
                        primeImage1: $primeImage1, primeImage2: $primeImage2,
                        validSymbol: validSymbol, invalidSymbol: invalidSymbol,
                        allowEditPrimes: .constant(true),
                        showUseDifferentPrimesCheckbox: false
                    )
                    
                    Button("Encode Message") {
                        encodeMessagePressed()                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .font(.system(.title3, design: .monospaced))

                    TextInScrollView(message: encodedMessage)

                    ScrollView(.horizontal) {
                        Text("Public Key: \(k) \(m)")
                    }
                }
                .opacity(currentView == 1 ? 0.1 : 1.0)
                .animation(.default, value: currentView)
            }
            .foregroundColor(.white)
        }
    }
}

struct DecodeButtonView: View {
    @State var buttonOpacity = 1.0
    @State var backgroundColor = Color.white.opacity(0.0)
    
    @EnvironmentObject var vc: ViewCoordinator
    
    var buttonAnimation = Animation.easeInOut(duration: 1)
        .repeatForever(autoreverses: true)
    
    @Binding var startAnimation: Bool
    
    var body: some View {
        Button("Decode") {
            vc.currentView = .exploreRSADecodeView
        }
        .buttonStyle(MenuButtonStyle())
        .background(
            backgroundColor,
            in: RoundedRectangle(cornerRadius: 10))
        .opacity(buttonOpacity)
        .animation(startAnimation ? buttonAnimation : nil, value: buttonOpacity)
        .onChange(of: startAnimation) {_ in
            if startAnimation {
                backgroundColor = Color.white.opacity(0.5)
                buttonOpacity = 0.5
            }
            else {
                backgroundColor = Color.white.opacity(0.0)
                buttonOpacity = 1.0
            }
        }
    }
}

struct ExploreRSAView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        NavigationView {
            ExploreRSAView()
                .environmentObject(rsa)
                .environmentObject(vc)
        }
    }
}
