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
            Group {
                Text("Your Message: \(rsa.inputMessageEng)")
                Divider()
                Text("Your Message in Numbers: \(rsa.inputMessageNum)")
                Divider()
                
                Text("Your prime numbers: \(String(rsa.prime1)) and \(String(rsa.prime2)). ").bold()
                Divider()
            }
            Text("Now let's split your numbers up into smaller pieces that are easier to manage").padding()
            HStack{
                ForEach(rsa.inputMessageNumList) { number in
                    Text(number.value)
                }
            }
            
            Button("Generate keys", action: {
                do {
                    try rsa.computePublicKeyK()
                    vc.currentView = .generateKeysView
                }
                catch {
                    print("Error computing the public key.")
                }
            })
        }
    }
}

struct SplitNumbersView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        SplitNumbersView()
            .environmentObject(rsa)
            .environmentObject(vc)

    }
}
