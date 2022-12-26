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
    
    func checkInputsAreValid() -> Bool {
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
    
    func decodeMessage() {
        rsa.computeInvPublicKeys()
        rsa.decodeRealAndFakeMessages()
        rsa.convertDecodedMessagesToEnglish()
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
                        // Check if primes are both valid
                        let inputsValid = checkInputsAreValid()

                        if inputsValid {
                            showDecodedMessage = true
                        }
                        else {
                            showDecodedMessage = false
                            errorMessage = .notPrimes
                        }
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

struct TextInScrollView: View {
    var message: String
    
    var body: some View {
        ScrollView() {
            Text("\(message)")
                .font(.system(.title))
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 5)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white, lineWidth: 3)
        )
    }
}

struct PrimeTextFieldsView: View {
    @Binding var prime1: String
    @Binding var prime2: String
    
    @Binding var primeImage1: String
    @Binding var primeImage2: String
    
    var validSymbol: String = "checkmark"
    var invalidSymbol: String = "multiply"
    
    @Binding var allowEditPrimes: Bool
    var showUseDifferentPrimesCheckbox = true
    var showGenerateRandomPrimesButton = true
        
    var title = "Primes"
    var titleTextStyle = Font.TextStyle.title
    
    var body: some View {
        Text(title)
            .monospacedTitleText(textStyle: titleTextStyle)
            .padding([.bottom], 5)
        
        Grid {
            GridRow {
                Image(systemName: primeImage1)
                    .opacity(prime1.count == 0 ? 0.0 : 1.0)
                    .foregroundColor(primeImage1 == validSymbol ? Color.green : Color.red)
                    .bold()
                
                Image(systemName: primeImage2)
                    .opacity(prime2.count == 0 ? 0.0 : 1.0)
                    .foregroundColor(primeImage2 == validSymbol ? Color.green : Color.red)
                    .bold()
            }.padding([.bottom], 5)
            GridRow {
                TextField("Prime 1", text: $prime1)
                    .borderedTextField(disable: !allowEditPrimes)
                    .onChange(of: prime1) { _ in
                        let p1 = validatePrime(p: prime1)
                        primeImage1 = p1 ? validSymbol : invalidSymbol
                    }
                
                TextField("Prime 2", text: $prime2)
                    .borderedTextField(disable: !allowEditPrimes)
                    .onChange(of: prime2) { _ in
                        let p2 = validatePrime(p: prime2)
                        primeImage2 = p2 ? validSymbol : invalidSymbol
                    }
            }
        }
        
        if showUseDifferentPrimesCheckbox  {
            Toggle(isOn: $allowEditPrimes) {
                Text("Use different primes")
            }
            .padding(2)
            .toggleStyle(ChecklistToggleStyle())
        }
        
        if showGenerateRandomPrimesButton {
            Button("Generate random primes") {
                prime1 = String(generatePrimeNumber())
                prime2 = String(generatePrimeNumber())
                
                primeImage1 = validSymbol
                primeImage2 = validSymbol
            }
            .buttonStyle(GenerateRandomPrimesButtonStyle())
            .disabled(!allowEditPrimes)
            .padding([.bottom], 10)
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
