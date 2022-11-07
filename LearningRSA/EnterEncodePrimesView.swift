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
    
    @State var prime1 = "12553" // TODO: Need to remove/replace these default primes
    @State var prime2 = "13007"
    @State var primeImage1 = ""
    @State var primeImage2 = ""
    
    let validSymbol = "checkmark"
    let invalidSymbol = "multiply"
    
    var body: some View {
        VStack {
            HStack{
                TextField("Enter the first prime number", text: $prime1)
                Image(systemName: primeImage1)
            }
            HStack {
                TextField("Enter the second prime number", text: $prime2)
                Image(systemName: primeImage2)
            }
            
            // TODO: need to store primes in rsa object if they are valid
            Button("Check if numbers are prime", action: {
                let p1 = isPrime(n: Int(prime1) ?? 0)
                let p2 = isPrime(n: Int(prime2) ?? 0)
                
                primeImage1 = p1 ? validSymbol : invalidSymbol
                primeImage2 = p2 ? validSymbol : invalidSymbol
            })
            
            Button("Generate random primes", action: {
                let p1 = generatePrimeNumber()
                let p2 = generatePrimeNumber()
                
                //TODO: What if p1 == p2?
                
                prime1 = String(p1)
                prime2 = String(p2)
            })
            
            Button("Next", action: {
                rsa.computeProductOfPrimes()
                rsa.splitInputNumberByDigits()
                
                vc.currentView = 4
            })
        }
    }
}

//struct EnterEncodePrimesView_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterEncodePrimesView()
//    }
//}
