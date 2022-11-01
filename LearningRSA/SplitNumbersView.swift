//
//  SplitNumbersView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/31/22.
//

import SwiftUI

struct SplitNumbersView: View {
    @EnvironmentObject var rsa: RSA
    
    var body: some View {
        VStack{
            Text(rsa.inputMessageStr)
            Text(rsa.inputMessageNum)
     
            ForEach(rsa.inputMessageNumList) { number in
                Text(String(number.value))
            }
            
            Button("Generate keys", action: {
                do {
                    try rsa.computePublicKeyK()
                }
                catch {
                    print("Error computing the public key.")
                }
            })
        }
    }
}

//struct SplitNumbersView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplitNumbersView()
//    }
//}
