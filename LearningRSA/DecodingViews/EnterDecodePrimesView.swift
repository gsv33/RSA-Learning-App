//
//  EnterDecodePrimesView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/2/22.
//

import SwiftUI

// enter the wrong primes to see what will happen
// This view loads after the correct primes have already
// been entered!
struct EnterFakePrimesView: View {
    @EnvironmentObject var rsa: RSA
    
    @State var showInfoSheet = false
    @Binding var showNextView: Bool
    
    @State var prime1 = ""
    @State var prime2 = ""
    
    @State var primeImage1 = "checkmark"
    @State var primeImage2 = "checkmark"
    
    @Binding var errorMessage: ErrorMessages
    
    let validSymbol = "checkmark"
    let invalidSymbol = "multiply"
    
    // updates RSA algorithm with both real and fake primes
    func updateRSA() {
        rsa.realDecodePrime1 = rsa.prime1
        rsa.realDecodePrime2 = rsa.prime2
        
        rsa.fakeDecodePrime1 = Int(prime1)!
        rsa.fakeDecodePrime2 = Int(prime2)!
        
        rsa.computeDecryptionKeys()
        rsa.decodeRealAndFakeMessages()
    }
        
    var body: some View {
        VStack {
            Text("Now enter two incorrect prime numbers, just to see what kind of message you'll get!").padding()

            PrimeTextFieldsView(
                prime1: $prime1, prime2: $prime2,
                primeImage1: $primeImage1, primeImage2: $primeImage2,
                errorMessage: $errorMessage,
                allowEditPrimes: .constant(true),
                showUseDifferentPrimesCheckbox: false,
                showGenerateRandomPrimesButton: true,
                title: "Fake Primes", titleTextStyle: .title3
            )
            
            MoreInfoButton(
                showInfoSheet: $showInfoSheet,
                InfoView: EnterDecodePrimesInfoView()
            )
            
            Button("Next!") {
                let validInputs = validateInputs(prime1: prime1, prime2: prime2,
                                                 primeImage1: &primeImage1, primeImage2: &primeImage2,
                                                 errorMessage: &errorMessage)
                
                if validInputs {
                    updateRSA()
                    showNextView = true
                }
            }
            .buttonStyle(MenuButtonStyle())
        }
    }
}

struct EnterRealPrimesView: View {
    @EnvironmentObject var rsa: RSA
    
    @State var primeImage1 = "checkmark"
    @State var primeImage2 = "checkmark"
        
    @Binding var hideText: Bool
    @Binding var errorMessage: ErrorMessages
    
    var body: some View {
        VStack {
            
            if hideText == false {
                Text("Let's start decoding your message!")
                Text("The first thing to do is enter the same prime numbers you used to encode your message. We've filled that out for you.").padding()
            }
            
            PrimeTextFieldsView(
                prime1: .constant(String(rsa.prime1)), prime2: .constant(String(rsa.prime2)),
                primeImage1: $primeImage1, primeImage2: $primeImage2,
                errorMessage: $errorMessage,
                allowEditPrimes: .constant(false),
                showUseDifferentPrimesCheckbox: false,
                showGenerateRandomPrimesButton: false,
                title: "Real Primes", titleTextStyle: .title3
            )
        }
    }
}

struct EnterDecodePrimesView: View {
    @EnvironmentObject var rsa: RSA
    
    @State var showFakePrimesView = false    
    @State var showNextView = false

    let titleText = "Decoding Primes"
    @State var errorMessage = ErrorMessages.noError
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: DecodingMathView(), isActive: $showNextView) {}
                .isDetailLink(false)
                .toolbar { NavigationToolbar(currentView: .enterDecodePrimesView, titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack {
                ErrorMessageBar(errorMessage: errorMessage).padding()
                
                EnterRealPrimesView(hideText: $showFakePrimesView, errorMessage: $errorMessage)

                if !showFakePrimesView {
                    Button("Next") {
                        withAnimation(.easeIn(duration: 0.50)) {
                            showFakePrimesView = true
                        }
                    }
                    .buttonStyle(MenuButtonStyle())
                    .padding()
                } else {
                    EnterFakePrimesView(showNextView: $showNextView, errorMessage: $errorMessage)
                }
                
            }.monospacedBodyText()
        }
    }
}

struct EnterDecodePrimesView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()

    static var previews: some View {
        
        NavigationView {
            EnterDecodePrimesView()
                .environmentObject(rsa)
        }
    }
}
