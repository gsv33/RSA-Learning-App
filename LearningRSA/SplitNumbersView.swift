//
//  SplitNumbersView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/31/22.
//

import SwiftUI

struct SplitNumbersView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
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
                    vc.currentView = 5
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
