//
//  EnterEncodePrimesView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI

struct EnterEncodePrimesView: View {
    @EnvironmentObject var rsa: RSA
    @State var prime1 = ""
    @State var prime2 = ""
    
    
    var body: some View {
        VStack {
            TextField("Enter the first prime number", text: $prime1)
            TextField("Enter the second prime number", text: $prime2)
            
            // need to store primes in rsa object if they are valid
            Button("Check if numbers are prime", action: {})
            
            Button("Generate random primes", action: {})
            
            Button("Next", action: {
                rsa.computeProductOfPrimes()
                rsa.splitInputNumberByDigits()
            })
        }
    }
}

//struct EnterEncodePrimesView_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterEncodePrimesView()
//    }
//}
