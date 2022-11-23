//
//  EnterPrimesView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/22/22.
//
//  View that allows the users to enter prime numbers
//  Will be used twice for the decoding stage

//  TODO: Not using this because it adds too much unneeded complexity

import SwiftUI

struct EnterPrimesView: View {
    @Binding var prime1Binding: String
    @Binding var prime2Binding: String
    
    @State var prime1 = ""
    @State var prime2 = ""
    
    @State var primeImage1 = "checkmark"
    @State var primeImage2 = "checkmark"
    
    let validSymbol = "checkmark"
    let invalidSymbol = "multiply"
    
    var body: some View {
        VStack {
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
            
            Button("Next") {
                let p1 = validateEnteredPrime(s: prime1)
                let p2 = validateEnteredPrime(s: prime2)
                
                primeImage1 = p1 ? validSymbol : invalidSymbol
                primeImage2 = p2 ? validSymbol : invalidSymbol
                
                if p1 && p2 {
                    prime1Binding = prime1
                    prime2Binding = prime2
                }
            }
        }
    }
}

struct EnterPrimesView_Previews: PreviewProvider {
    @State static var prime1 = ""
    @State static var prime2 = ""
    
    static var previews: some View {
        EnterPrimesView(prime1Binding: $prime1, prime2Binding: $prime2)
    }
}
