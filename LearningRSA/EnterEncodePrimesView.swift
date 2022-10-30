//
//  EnterEncodePrimesView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI

struct EnterEncodePrimesView: View {
    @EnvironmentObject var rsa: RSA
    
    var body: some View {
        VStack {
            TextField("Enter the first prime number", text: $rsa.prime1)
            TextField("Enter the second prime number", text: $rsa.prime1)
            
            Button("Check if numbers are prime", action: {})
            
            Button("Generate random primes", action: {})
        }
    }
}

//struct EnterEncodePrimesView_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterEncodePrimesView()
//    }
//}
