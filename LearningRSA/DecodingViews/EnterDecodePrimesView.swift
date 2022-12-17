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
    
    @Binding var showNextView: Bool
    
    @State var prime1 = ""
    @State var prime2 = ""
    
    @State var primeImage1 = "checkmark"
    @State var primeImage2 = "checkmark"
    
    let validSymbol = "checkmark"
    let invalidSymbol = "multiply"
    
    var body: some View {
        VStack {
            Text("Now, just for fun let's try to enter the wrong prime numbers, to see what kind of message you'll get!").padding()

            Grid {
                GridRow{
                    Text("Prime 1: ")
                    TextField("", text: $prime1)
                        .textFieldStyle(.roundedBorder)
                    Image(systemName: primeImage1)
                        .foregroundColor(primeImage1 == validSymbol ? Color.green : Color.red)
                }
                GridRow {
                    Text("Prime 2: ")
                    TextField("", text: $prime2)
                        .textFieldStyle(.roundedBorder)
                    Image(systemName: primeImage2)
                        .foregroundColor(primeImage2 == validSymbol ? Color.green : Color.red)
                }
            }
            .padding()

            Button("Generate Random Prime Numbers for me!") {
                let p1 = generatePrimeNumber()
                let p2 = generatePrimeNumber()
                
                prime1 = String(p1)
                prime2 = String(p2)
            }.padding()
            
            Button("Next!") {
                // validate primes
                let p1 = validatePrime(p: prime1)
                let p2 = validatePrime(p: prime2)

                primeImage1 = p1 ? validSymbol : invalidSymbol
                primeImage2 = p2 ? validSymbol : invalidSymbol
                
                if p1 && p2 {
                    rsa.fakeDecodePrime1 = Int(prime1)!
                    rsa.fakeDecodePrime2 = Int(prime2)!
                    
                    showNextView = true
                }
            }
        }
    }
}

struct EnterRealPrimesView: View {
    @EnvironmentObject var rsa: RSA
    
    @Binding var showNextView: Bool
    
    @State var prime1 = ""
    @State var prime2 = ""
    
    @State var primeImage1 = "checkmark"
    @State var primeImage2 = "checkmark"
    
    @State var disableTextFields = false
    
    let validSymbol = "checkmark"
    let invalidSymbol = "multiply"
    
    // enter the same prime numbers used for encoding
    func fillInPrimeNumbers() {
        prime1 = String(rsa.prime1)
        prime2 = String(rsa.prime2)
    }
    
    var body: some View {
        VStack {
            Text("Let's start decoding your message!")
            Text("The first thing you need to do is enter the same prime numbers you used to encode your message.").padding()
            
            Grid {
                GridRow{
                    Text("Prime 1: ")
                    TextField("", text: $prime1)
                        .textFieldStyle(.roundedBorder)
                        .disabled(disableTextFields)
                    Image(systemName: primeImage1)
                        .foregroundColor(primeImage1 == validSymbol ? Color.green : Color.red)
                }
                GridRow {
                    Text("Prime 2: ")
                    TextField("", text: $prime2)
                        .textFieldStyle(.roundedBorder)
                        .disabled(disableTextFields)
                    Image(systemName: primeImage2)
                        .foregroundColor(primeImage2 == validSymbol ? Color.green : Color.red)
                }
            }
            .padding()

            HStack {
                Button("Don't remember?") {
                    if disableTextFields == false {
                        fillInPrimeNumbers()
                    }
                }
                
                Button("Next!") {
                    if disableTextFields == false {
                        // validate primes
                        let p1 = prime1 == String(rsa.prime1)
                        let p2 = prime2 == String(rsa.prime2)
                        
                        primeImage1 = p1 ? validSymbol : invalidSymbol
                        primeImage2 = p2 ? validSymbol : invalidSymbol
                        
                        if p1 && p2 {
                            // show next view
                            disableTextFields = true
                            
                            rsa.realDecodePrime1 = Int(prime1)!
                            rsa.realDecodePrime2 = Int(prime2)!
                            
                            showNextView = true
                        }
                    }
                }
            }.padding()
        }
    }
}

struct EnterDecodePrimesView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    @State var showFakePrimesView = false
    @State var moveToDecodingMathView = false
    
    var body: some View {
        VStack {
            EnterRealPrimesView(showNextView: $showFakePrimesView)
            
            if showFakePrimesView {
                EnterFakePrimesView(showNextView: $moveToDecodingMathView)
                    .onChange(of: moveToDecodingMathView) { _ in
                        if moveToDecodingMathView {
                            rsa.computeInvPublicKeys()
                            rsa.decodeRealAndFakeMessages()
                            vc.currentView = .decodingMathView
                        }
                    }
            }
        }
    }
}

struct EnterDecodePrimesView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        EnterDecodePrimesView()
            .environmentObject(rsa)
            .environmentObject(vc)
    }
}


// FOR TESTING PURPOSES, DOES ALL ENCODING PREPWORK
//                Button("Enter", action: {
//                    rsa.stringToNumberConversion()
//                    rsa.computeProductOfPrimes()
//                    rsa.splitInputNumberByDigits()
//                    try! rsa.computePublicKeyK()
//                    rsa.encodeMessage()
//                    rsa.computeInvPublicKeyK()
//                    rsa.decodeMessage()
//                    rsa.numberToStringConversion()
//                })
