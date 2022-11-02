//
//  ContentView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/27/22.
//

import SwiftUI


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
                    NavigationLink("Convert message to numbers") {MessageToNumbersView()}
                    NavigationLink("Enter primes to encode") { EnterEncodePrimesView() }
                    NavigationLink("Split numbers") { SplitNumbersView() }
                    NavigationLink("Generate keys") { GenerateKeysView() }
                    NavigationLink("Encoded Message") { EncodeMessageView() }
                    NavigationLink("Enter primes to decode") { EnterDecodePrimesView() }
                    NavigationLink("Calculate phi and u") { DecodingMathView() }
                    NavigationLink("Decode message") { DecodedMessageView()}
                    NavigationLink("Decoded message to text") { NumbersToTextView() }
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
