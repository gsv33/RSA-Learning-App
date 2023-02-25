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
    @FocusState private var focusedField: FocusedField?
    @Binding var keyboardActive: Bool
        
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
            
            if !keyboardActive {
                Text("Now enter two incorrect prime numbers, just to see how it will affect the decoded message.").padding()
            } else {
                Text("Enter two incorrect primes below.")
                    .padding(.top, -10)
                    .padding([.bottom])
            }

            PrimeTextFieldsView(
                prime1: $prime1, prime2: $prime2,
                primeImage1: $primeImage1, primeImage2: $primeImage2,
                focusedField: $focusedField,
                errorMessage: $errorMessage,
                allowEditPrimes: .constant(true),
                showUseDifferentPrimesCheckbox: false,
                showGenerateRandomPrimesButton: true,
                title: "Fake Primes", titleTextStyle: .title3
            )
            
            MoreInfoButton(
                showInfoSheet: $showInfoSheet,
                InfoView: EnterDecodePrimesInfoView()
            ).padding(.top)
            
            Button("Next") {
                let validInputs = validateInputs(prime1: prime1, prime2: prime2,
                                                 primeImage1: &primeImage1, primeImage2: &primeImage2,
                                                 errorMessage: &errorMessage)
                
                if validInputs {
                    updateRSA()
                    focusedField = nil
                    showNextView = true
                }
            }
            .purpleButtonStyle()
            .padding(.top)
        }
        .onChange(of: focusedField) {newValue in
            withAnimation {
                keyboardActive = newValue != nil ? true : false
            }
        }
    }
}

struct EnterDecodePrimesView: View {
    @EnvironmentObject var rsa: RSA
    
    @State var showFakePrimesView = false    
    @State var showNextView = false
    
    @State var primeImage1 = "checkmark"
    @State var primeImage2 = "checkmark"

    @FocusState private var focusedField: FocusedField?
    @State private var keyboardActive = false
    
    let titleText = "Decoding Primes"
    @State var errorMessage = ErrorMessages.noError
    
    var body: some View {
        VStack {
            NavigationLink(destination: DecodingMathView(), isActive: $showNextView) {}
                .isDetailLink(false)
                .toolbar { NavigationToolbar(currentView: .enterDecodePrimesView, titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)

            ErrorMessageBar(errorMessage: errorMessage).padding([.top, .bottom])
            
            if !showFakePrimesView {
                Text("Let's start decoding your message!").padding([.leading, .trailing])
                Text("The first step is to enter the same prime numbers you used to encode your message. We've filled that out for you.").padding()
            }
            
            if !keyboardActive {                
                PrimeTextFieldsViewDuplicate(
                    prime1: String(rsa.prime1),
                    prime2: String(rsa.prime2),
                    title: "Encoding Primes",
                    titleTextStyle: .title3
                )
            }

            if !showFakePrimesView {
                Button("Next") {
                    withAnimation(.easeIn(duration: 0.50)) {
                        showFakePrimesView = true
                    }
                }
                .purpleButtonStyle()
                .padding()
            } else {
                EnterFakePrimesView(showNextView: $showNextView,
                                    errorMessage: $errorMessage,
                                    keyboardActive: $keyboardActive)
            }
            
            Spacer()
            
        }.monospacedBodyText()
    }
}

struct EnterDecodePrimesView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()

    static var previews: some View {
        
        NavigationView {
            EnterDecodePrimesView()
                .environmentObject(rsa)
                .preferredColorScheme(.dark)
        }
    }
}
