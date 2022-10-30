//
//  ContentView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/27/22.
//

import SwiftUI

// Note: This is NOT a secure implementation of RSA. It is just a tool for learning
// about the algorithm.
class RSA: ObservableObject {
    var charToNumEncoding: [Character: Int] = ["A": 11, "B": 12, "C": 13, "D": 14, "E": 15, "F": 16,
                                               "G": 17, "H": 18, "I": 19, "J": 20, "K": 21, "L": 22,
                                               "M": 23, "N": 24, "O": 25, "P": 26, "Q": 27, "R": 28,
                                               "S": 29, "T": 30, "U": 31, "V": 32, "W": 33, "X": 34,
                                               "Y": 35, "Z": 36, " ": 37]
    
    var inputMessage: String = "Test"
    var inputNumber: String = ""
    var prime1: String = "12553"
    var prime2: String = "13007"
    
    var productOfPrimes: Int {
        return Int(prime1)! * Int(prime2)!
    }
}

struct ContentView: View {
    @StateObject var rsa = RSA()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Explore the RSA Cryptosystem!")
            
            NavigationStack {
                List {
                    NavigationLink("Enter message") { EnterMessageView() }
                    NavigationLink("Enter primes to encode") { EnterEncodePrimesView() }
                    NavigationLink("Convert message to numbers") {MessageToNumbersView()}
//                    NavigationLink("Generate keys") { GenerateKeysView() }
//                    NavigationLink("Encode Message") { EncodeMessageView() }
//                    NavigationLink("Enter primes to decode!") { EnterDecodePrimesView() }
                }
                .navigationTitle("RSA Steps")
            }
            .environmentObject(rsa)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
