//
//  ExploreRSAView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/27/22.
//  Full RSA functionality on one page for exploration purposes

import SwiftUI

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
    
    func checkInputsAreValid() -> Bool {
        // validate entered message
        if inputMessage.count == 0 {
            errorMessage = .noMessage
            return false
        }
        
        let p1 = validatePrime(p: prime1)
        let p2 = validatePrime(p: prime2)
        
        primeImage1 = p1 ? validSymbol : invalidSymbol
        primeImage2 = p2 ? validSymbol : invalidSymbol

        guard p1 && p2 else {
            errorMessage = .notPrimes
            return false
        }
        
        return true
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Group {
                    HStack {
                        Button("Menu") {vc.currentView = .welcomeView}
                            .buttonStyle(MenuButtonStyle())

                        Spacer()
                    }.padding([.leading])
                }.padding([.bottom], 5)

                Group {

                    ErrorMessageBar(errorMessage: errorMessage)
                    
                    Text("Encode your message")
                        .font(.system(.title, design: .monospaced))
                    
                    MessageFieldView(
                        textFieldMessage: $textFieldMessage,
                        inputMessage: $inputMessage,
                        errorMessage: $errorMessage,
                        maxCharsInMessage: maxCharsInMessage
                    )
                    .frame(maxHeight: .infinity)
                    .foregroundColor(.black)
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
                        let inputsValid = checkInputsAreValid()
                        
                        if inputsValid {
                            encodeMessage()
                            startDecodeButtonAnimation = true
                        }
                        else {
                            errorMessage = ErrorMessages.encodeMessage
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .font(.system(.title3, design: .monospaced))
                }
                
                Group {
                    TextInScrollView(message: encodedMessage)

                    ScrollView(.horizontal) {
                        Text("Public Key: \(k) \(m)")
                    }
                    
                }
                
                Group {
                    HStack {
                        Button("Clear") {clearInputs()}
                            .buttonStyle(MenuButtonStyle())
                        Spacer()
                        DecodeButtonView(startAnimation: $startDecodeButtonAnimation)
                        
                    }.padding([.leading, .trailing])
                }
                
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
        ExploreRSAView()
            .environmentObject(rsa)
            .environmentObject(vc)
    }
}
