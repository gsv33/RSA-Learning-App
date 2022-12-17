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
    @State var errorMessage = "Test error message"
    
    let validSymbol = "checkmark"
    let invalidSymbol = "multiply"
    let maxDigitsInPrime: Double = 5 // TODO: What's a good setting for this number?
        
    var body: some View {
        VStack {
            Text(errorMessage)
                .padding()
                .foregroundColor(errorMessage == "Success!" ? Color.green : Color.red)
                .bold()
            
            Text("Enter two prime numbers. This will be used to create your SECRET KEY, and will secure your message!")
            
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
            
            Button("Generate random primes", action: {
                let p1 = generatePrimeNumber()
                let p2 = generatePrimeNumber()
                
                //TODO: What if p1 == p2?
                
                prime1 = String(p1)
                prime2 = String(p2)
                
                primeImage1 = validSymbol
                primeImage2 = validSymbol
            })
            
            Button("Next", action: {
                let p1 = validatePrime(p: prime1, maxDigitsInPrime: maxDigitsInPrime)
                let p2 = validatePrime(p: prime2, maxDigitsInPrime: maxDigitsInPrime)
                                
                primeImage1 = p1 ? validSymbol : invalidSymbol
                primeImage2 = p2 ? validSymbol : invalidSymbol

                if p1 && p2 {
                    errorMessage = "Success!"
                    
                    rsa.prime1 = Int(prime1)!
                    rsa.prime2 = Int(prime2)!
                    
                    rsa.computeProductOfPrimes()
                    rsa.splitInputNumberByDigits()
                                        
                    vc.currentView = .splitNumbersView
                }
                else {
                    errorMessage = "Please enter two prime numbers with less than \(Int(maxDigitsInPrime)) digits each"
                }
            })
        }
    }
}

struct EnterEncodePrimesView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        EnterEncodePrimesView()
            .environmentObject(rsa)
            .environmentObject(vc)
    }
}
