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
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: GenerateKeysView(), isActive: $showNextView) {}
                .isDetailLink(false)
                .toolbar { NavigationToolbar(currentView: .enterEncodePrimesView, titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            ScrollView {
                VStack {
                    ErrorMessageBar(errorMessage: errorMessage).padding([.top, .bottom], 5)
                    
                    Text("This is where we start to encrypt your message. Enter two prime numbers below.")
                        .padding([.leading, .trailing])
                    
                    Text("These two numbers are used to secure your message. Anyone who knows them will be able to decipher your message.")
                        .padding([.top, .leading, .trailing])
                    
                    MoreInfoButton(showInfoSheet: $showInfoSheet, InfoView: EnterPrimesInfoView())
                        .padding([.top, .bottom])
                    
                    PrimeTextFieldsView(
                        prime1: $prime1, prime2: $prime2,
                        primeImage1: $primeImage1, primeImage2: $primeImage2,
                        errorMessage: $errorMessage,
                        allowEditPrimes: .constant(true),
                        showUseDifferentPrimesCheckbox: false
                    )
                    
                    Text("Next, create your encryption key. This is publicly available and will let anyone encode a message and send it to you.")
                        .padding()
                    
                    Button("Create Encryption Key") {
                        let validInputs = validateInputs(prime1: prime1, prime2: prime2,
                                                         primeImage1: &primeImage1, primeImage2: &primeImage2,
                                                         errorMessage: &errorMessage)
                        
                        if validInputs {
                            let successfulUpdate = updateRSA()
                            
                            if successfulUpdate {
                                showNextView = true
                            }
                            else {
                                // TODO: What should we do if there's an error?
                            }
                        }
                    }
                    .buttonStyle(MenuButtonStyle())
                    .padding(.bottom)
                }
                .monospacedBodyText()
            }.onAppear {
                loadPrimes()
            }
        }
    }
}

struct EnterEncodePrimesView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()

    static var previews: some View {
        NavigationView {
            EnterEncodePrimesView()
                .environmentObject(rsa)
        }
    }
}
