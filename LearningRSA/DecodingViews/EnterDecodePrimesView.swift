//
//  EnterDecodePrimesView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/2/22.
//

import SwiftUI

struct EnterDecodePrimesView: View {
    @EnvironmentObject var rsa: RSA
    
    var body: some View {
        
        Text("Testing app.. Info coming")
        
        Button("Enter", action: {
            // do all encoding prep work for now
            rsa.stringToNumberConversion()
            rsa.computeProductOfPrimes()
            rsa.splitInputNumberByDigits()
            try! rsa.computePublicKeyK()
            rsa.encodeMessage()
            rsa.computeInvPublicKeyK()
            rsa.decodeMessage()
            rsa.numberToStringConversion()
        })
    }
}

//struct EnterDecodePrimesView_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterDecodePrimesView()
//    }
//}
