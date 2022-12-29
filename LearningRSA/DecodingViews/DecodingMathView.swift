//
//  DecodingMathView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/2/22.
//

import SwiftUI

struct FakeDecodingMathView: View {
    @EnvironmentObject var rsa: RSA

    @State private var showPhiEquation = true
    @Binding var decodingAnimationFinished: Bool
    
    var body: some View {
        let fakePrime1 = String(rsa.fakeDecodePrime1)
        let fakePrime2 = String(rsa.fakeDecodePrime2)
        let fakePhi = String(rsa.fakeDecodePhi)
        let fakeInvK = String(rsa.fakeInvPublicKeyK)
        
        VStack {
            Text("Now, using the fake primes, here's what you would have gotten.").padding()
            
            Text("Decoding prime numbers: \(fakePrime1) and \(fakePrime2).")
            
            if showPhiEquation {
                VStack {
                    Text("Φ = (p - 1) x (q - 1)")
                    Text("Φ = (\(fakePrime1) - 1) x (\(fakePrime2) - 1) = \(fakePhi)")
                }
            }
            
            Text("Now we need to use this to calculate k^-1 mod phi").padding()
            Text("We do this with the Euclidean Algorithm!")
            Text("Here's what we get k = \(fakeInvK)")
            
            EncodedMessageOutputList(
                inputs: rsa.encodedMessageNumList,
                outputs: rsa.fakeDecodedMessageNumList,
                animationFinished: $decodingAnimationFinished,
                hideText: .constant(false)
            )
        }
    }
}

struct RealDecodingMathView: View {
    @EnvironmentObject var rsa: RSA
    
    @State private var showPhiEquation = true
    @Binding var decodingAnimationFinished: Bool
    
    var body: some View {
        let realPrime1 = String(rsa.realDecodePrime1)
        let realPrime2 = String(rsa.realDecodePrime2)
        let realPhi = String(rsa.realDecodePhi)
        let realInvK = String(rsa.realInvPublicKeyK)
        
        VStack {
            Text("First, we calculate your decoding function. This is the Φ function, and is the glue that holds the entire cryptosystem together. This is why we kept the primes secret, because we need to calculate this one number.").padding()
            
            Text("Decoding prime numbers: \(realPrime1) and \(realPrime2).")
            
            if showPhiEquation {
                VStack {
                    Text("Φ = (p - 1) x (q - 1)")
                    Text("Φ = (\(realPrime1) - 1) x (\(realPrime2) - 1) = \(realPhi)")
                }
            }
            
            Text("Now we need to use this to calculate k^-1 mod phi").padding()
            Text("We do this with the Euclidean Algorithm!")
            Text("Here's what we get k = \(realInvK)")
            
            EncodedMessageOutputList(
                inputs: rsa.encodedMessageNumList,
                outputs: rsa.realDecodedMessageNumList,
                animationFinished: $decodingAnimationFinished,
                hideText: .constant(false)
            )
        }
    }
}

struct DecodingMathView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator

    @State private var realAnimationFinished = false
    @State private var fakeAnimationFinished = false
    
    var body: some View{
        
        VStack {
            RealDecodingMathView(decodingAnimationFinished: $realAnimationFinished)
            
            if realAnimationFinished {
                FakeDecodingMathView(decodingAnimationFinished: $fakeAnimationFinished)
            }
            
            if fakeAnimationFinished {
                Button("Next") {
                    rsa.convertDecodedMessagesToEnglish()
                    vc.currentView = .decodedMessageView
                }
            }
        }
    }
}

struct DecodingMathView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        DecodingMathView()
            .environmentObject(rsa)
            .environmentObject(vc)
        
    }
}
