//
//  EnterEncodePrimesView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI

struct EnterEncodePrimesView: View {
    @EnvironmentObject var rsa: RSA
    
    @State var prime1 = ""
    @State var prime2 = ""
    @State var primeImage1 = "checkmark"
    @State var primeImage2 = "checkmark"
    @State var errorMessage: ErrorMessages = .noError
        
    let titleText = "Prime Numbers"
    
    @State var showInfoSheet = false
    @State var showNextView = false
    @State var hideText = false
    
    @FocusState private var focusedField: FocusedField?
        
    // updates RSA with the entered primes
    // also computes next steps in RSA algorithm
    func updateRSA() -> Bool {
        rsa.prime1 = Int(prime1)!
        rsa.prime2 = Int(prime2)!
        
        rsa.splitInputNumberByDigits()
        let success = rsa.computeEncryptionKeyE()
        
        return success
    }
    
    // if the primes have already been chosen and
    // rsa has not yet been reset, load those primes
    func loadPrimes() {
        if rsa.prime1 != 0 && rsa.prime2 != 0 {
            prime1 = String(rsa.prime1)
            prime2 = String(rsa.prime2)
        }
    }
    
    var body: some View {
        
//        GeometryReader { geometry in
//            ScrollView {
                VStack {
                    NavigationLink(destination: GenerateKeysView(), isActive: $showNextView) {}
                        .isDetailLink(false)
                        .toolbar { NavigationToolbar(currentView: .enterEncodePrimesView, titleText: titleText) }
                        .navigationBarBackButtonHidden()
                        .navigationBarTitleDisplayMode(.inline)
                    
                    ErrorMessageBar(errorMessage: errorMessage)
                        .padding(.top, hideText ? 10 : -10)
                    
                    Text("Enter two prime numbers below.")
                        .padding([.leading, .trailing])
                        .padding(.top, 5)
                    
                    if !hideText {
                        Text("These two numbers are used to secure your message. Anyone who knows them will be able to decipher your message.")
                            .padding([.top, .leading, .trailing])
                    }
                    
                    MoreInfoButton(showInfoSheet: $showInfoSheet, InfoView: EnterPrimesInfoView())
                        .padding(.top, 5)
                    
                    if !hideText {
                        Text("Primes")
                            .monospacedTitleText(textStyle: .title)
                            .padding([.bottom], 5)
                            .padding(.top)
                    }
                    else {
                        Text("")
                    }
                    
                    PrimeTextFieldsView(
                        prime1: $prime1, prime2: $prime2,
                        primeImage1: $primeImage1, primeImage2: $primeImage2,
                        focusedField: $focusedField,
                        errorMessage: $errorMessage,
                        allowEditPrimes: .constant(true),
                        showUseDifferentPrimesCheckbox: false,
                        hideTitle: true
                    )
                    
                    if !hideText {
                        ViewThatFits {
                            Text("Next, create your encryption key. This is publicly available and will let anyone encode a message and send it to you.").padding()
                            Text("Next, create your publicly available encryption key.").padding()
                        }
                    }
                    else {
                        ViewThatFits {
                            Text("Next, create your encryption key.").padding()
                            Text("Now create your encryption key.").padding()
                        }
                    }
                    
                    Button("Create Encryption Key") {
                        let validInputs = validateInputs(prime1: prime1, prime2: prime2,
                                                         primeImage1: &primeImage1, primeImage2: &primeImage2,
                                                         errorMessage: &errorMessage)
                        
                        if validInputs {
                            let successfulUpdate = updateRSA()
                            
                            if successfulUpdate {
                                focusedField = nil
                                showNextView = true
                            }
                            else {
                                // TODO: What should we do if there's an error?
                            }
                        }
                    }
                    .purpleButtonStyle()
                    .padding(.bottom)
                }
                .onChange(of: focusedField) {newValue in
                    withAnimation {
                        hideText = newValue != nil ? true : false
                    }
                }
//                .frame(minWidth: geometry.size.width, minHeight: geometry.size.height)
                .monospacedBodyText()
                .onAppear { loadPrimes() }
//            }
//        }
    }
}

struct EnterEncodePrimesView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()

    static var previews: some View {
        NavigationView {
            EnterEncodePrimesView()
                .environmentObject(rsa)
        }.preferredColorScheme(.dark)
    }
}
