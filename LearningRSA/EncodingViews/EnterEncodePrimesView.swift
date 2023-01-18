//
//  EnterEncodePrimesView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI

struct EnterEncodePrimesView: View {
    @EnvironmentObject var rsa: RSA
    
    @State var prime1 = "4241" // TODO: Need to remove/replace these default primes
    @State var prime2 = "7331"
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
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: GenerateKeysView(), isActive: $showNextView) {}
                .isDetailLink(false)
                .toolbar { NavigationToolbar(titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack {
                ErrorMessageBar(errorMessage: errorMessage)
                
                Text("This is where we start to encrypt your message. Enter two prime numbers below.")
                    .padding()
                
                Text("These two numbers are used to secure your private key. Anyone who knows them will be able to decipher your message.")
                    .padding()
                
                MoreInfoButton(showInfoSheet: $showInfoSheet, InfoView: EnterPrimesInfoView())
                    .padding()
                
                PrimeTextFieldsView(
                    prime1: $prime1, prime2: $prime2,
                    primeImage1: $primeImage1, primeImage2: $primeImage2,
                    errorMessage: $errorMessage,
                    allowEditPrimes: .constant(true),
                    showUseDifferentPrimesCheckbox: false
                )
                                
                Text("Next, create your public key. This will let anyone communicate with you.")
                    .padding()
                
                Button("Create public key") {
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
            }
            .monospacedBodyText()
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
