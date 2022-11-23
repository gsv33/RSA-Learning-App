//
//  GenerateKeysView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/1/22.
//

import SwiftUI

struct GenerateKeysView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    var body: some View {
        VStack {
            Text("Using your entered prime numbers, we find a new number such that has no common factors with the product of your prime numbers")
                .padding()
            
            Divider()
            Text("Product of prime numbers: ")
            Text("\(String(rsa.prime1)) x \(String(rsa.prime2)) = \(String(rsa.productOfPrimes))").bold()
            Divider()

            Text("Public Key K: " + String(rsa.publicKeyK))

            Divider()
            
            Text("Now that everything's set up, the next thing to do is to encode your message!")
                .padding()
            
            Button("Encode message", action: {
                rsa.encodeMessage()
                vc.currentView = .encodeMessageView
            })
        }
    }
}

struct GenerateKeysView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        GenerateKeysView()
            .environmentObject(rsa)
            .environmentObject(vc)
    }
}
