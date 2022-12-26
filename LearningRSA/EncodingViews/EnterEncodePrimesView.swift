//
//  EnterEncodePrimesView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI

struct EnterEncodePrimesView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    @State var prime1 = "4241" // TODO: Need to remove/replace these default primes
    @State var prime2 = "7331"
    @State var primeImage1 = "checkmark"
    @State var primeImage2 = "checkmark"
    @State var errorMessage: ErrorMessages = .noError
    
    let validSymbol = "checkmark"
    let invalidSymbol = "multiply"
    let maxDigitsInPrime: Double = 5 // TODO: What's a good setting for this number?
    
    let titleText = "Private Key"
    
    @State var showInfoPopover = false
    @State var showNextView = false
    
    func checkInputsAreValid() -> Bool {
        let p1 = validatePrime(p: prime1, maxDigitsInPrime: maxDigitsInPrime)
        let p2 = validatePrime(p: prime2, maxDigitsInPrime: maxDigitsInPrime)
        
        primeImage1 = p1 ? validSymbol : invalidSymbol
        primeImage2 = p2 ? validSymbol : invalidSymbol
        
        if p1 && p2 {
            return true
        } else {
            errorMessage = .notPrimes
            return false
        }
    }
    
    // updates RSA with the entered primes
    // also computes next steps in RSA algorithm
    func updateRSAWithPrimes() {
        rsa.prime1 = Int(prime1)!
        rsa.prime2 = Int(prime2)!
        
        rsa.computeProductOfPrimes()
        rsa.splitInputNumberByDigits()
    }
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: GenerateKeysView(), isActive: $showNextView) {}
                .toolbar { NavigationToolbar(titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack {
                ErrorMessageBar(errorMessage: errorMessage)
                
                Text("This is where we start to encrypt your message. Enter two prime numbers below.")
                    .padding()
                
                Text("These two numbers are your private key. Anyone who knows them will be able to decipher your message.")
                    .padding()
                
                Button(action: {
                    showInfoPopover = true
                }) {
                    Label("More Info", systemImage: "info.square")
                }
                .popover(isPresented: $showInfoPopover) { EnterPrimesInfoView() }
                .monospacedInfoText()
                .padding()

                
                PrimeTextFieldsView(
                    prime1: $prime1, prime2: $prime2,
                    primeImage1: $primeImage1, primeImage2: $primeImage2,
                    validSymbol: validSymbol, invalidSymbol: invalidSymbol,
                    allowEditPrimes: .constant(true),
                    showUseDifferentPrimesCheckbox: false
                )
                                
                Text("Next, create your public key. This will let anyone communicate with you.")
                    .padding()
                
                Button("Create public key") {
                    let inputsValid = checkInputsAreValid()
                    
                    if inputsValid {
                        updateRSAWithPrimes()
                        do {
                            try rsa.computePublicKeyK()
                            showNextView = true
                        }
                        catch {
                            // TODO: What should we do if there's an error?
                            print("Error computing the public key.")
                        }
                    }
                    else {
                        //TODO: Set appropriate error Message if primes are too long
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
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        NavigationView {
            EnterEncodePrimesView()
                .environmentObject(rsa)
                .environmentObject(vc)
        }
    }
}
