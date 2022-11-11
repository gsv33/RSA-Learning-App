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
                    .foregroundColor(primeImage1 == validSymbol ? Color.green : Color.red)
            }
            HStack {
                TextField("Enter the second prime number", text: $prime2)
                Image(systemName: primeImage2)
                    .foregroundColor(primeImage2 == validSymbol ? Color.green : Color.red)
            }
            
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
                let p1 = isPrime(n: Int(prime1) ?? 0)
                let p2 = isPrime(n: Int(prime2) ?? 0)
                
                primeImage1 = p1 ? validSymbol : invalidSymbol
                primeImage2 = p2 ? validSymbol : invalidSymbol

                if p1 && p2 {
                    rsa.prime1 = Int(prime1)!
                    rsa.prime2 = Int(prime2)!
                    
                    rsa.computeProductOfPrimes()
                    rsa.splitInputNumberByDigits()
                    
                    vc.currentView = 4
                }
            })
        }
    }
}

//struct EnterEncodePrimesView_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterEncodePrimesView()
//    }
//}
