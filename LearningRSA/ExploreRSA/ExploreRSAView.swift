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
        
        let p1 = validateEnteredPrime(s: prime1)
        let p2 = validateEnteredPrime(s: prime2)
        
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
                        Spacer()
                    }
                }.padding([.bottom], 5)

                Group {
                    Text(errorMessage.rawValue)
                        .foregroundColor(errorMessage == .success ? Color.green : Color.red)
                        .font(.system(.body, design: .monospaced, weight: .semibold))

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
                    Text("Primes")
                        .font(.system(.title, design: .monospaced))
                        .padding([.bottom], 5)
                    
                    Grid {
                        GridRow {
                            Image(systemName: primeImage1)
                                .foregroundColor(primeImage1 == validSymbol ? Color.green : Color.red)
                                .bold()

                            Image(systemName: primeImage2)
                                .foregroundColor(primeImage2 == validSymbol ? Color.green : Color.red)
                                .bold()
                        }.padding([.bottom], 5)
                        GridRow {
                            TextField("Prime 1", text: $prime1)
                                .font(.system(.title))
                                .textFieldStyle(.roundedBorder)
                                .foregroundColor(.black)
                                .fixedSize()
                                                    
                            TextField("Prime 2", text: $prime2)
                                .font(.system(.title))
                                .textFieldStyle(.roundedBorder)
                                .foregroundColor(.black)
                                .fixedSize()
                        }
                    }
                        
                    Button("Generate random primes") {
                        prime1 = String(generatePrimeNumber())
                        prime2 = String(generatePrimeNumber())
                        
                        primeImage1 = validSymbol
                        primeImage2 = validSymbol
                    }
                    .buttonStyle(.borderedProminent)
                    .font(.system(.title3, design: .monospaced))
                    .tint(.green)
                    .buttonBorderShape(.roundedRectangle)
                    .padding([.bottom], 20)
                    
                    Button("Encode Message") {
                        let inputsValid = checkInputsAreValid()
                        
                        if inputsValid {
                            encodeMessage()
                        }
                        else {
                            
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .font(.system(.largeTitle, design: .monospaced))
                }
                
                Group {
                    ScrollView() {
                        Text("\(encodedMessage)")
                            .font(.system(.title))
                            .padding([.top, .bottom], 10)
                            .padding([.leading, .trailing], 5)
                    }
                    .frame(maxWidth: .infinity)
                    .border(.white, width:3)
                    ScrollView(.horizontal) {
                        Text("Public Key: \(k) \(m)")
                    }
                    
                }
                
                Group {
                    HStack {
                        Button("Clear") {clearInputs()}
                        Spacer()
                        Button("Decode") {
                            vc.currentView = .exploreRSADecodeView
                        }
                    }.padding()
                }
                
            }
            .foregroundColor(.white)
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
