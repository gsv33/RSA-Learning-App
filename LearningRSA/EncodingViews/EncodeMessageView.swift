//
//  EncodeMessageView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/1/22.
//

import SwiftUI

struct EncodeMessageView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    @State private var animationFinished = false
    @State private var showMessage = false
    
    
    var body: some View {
        VStack{
            Group {
                Text("First, we take your input numbers: ")
                HStack {
                    ForEach(rsa.inputMessageNumList) { number in
                        Text(String(number.value))
                    }
                }
                
                Divider()
                
                Text("Then we use your public key and modular exponentiation to compute")

                EncodedMessageOutputList(animationFinished: $animationFinished)
            }
            
            if animationFinished {
                Text("Putting it all together, this is your encoded message! Do you think you could possibly guess what it corresponds to?").padding()
                
                Text(rsa.encodedMessageStr)
                
                Button(showMessage ? "Hide original message" : "HINT: Reveal Original message") {
                    showMessage.toggle()
                }
                
                if showMessage {
                    Text("\(rsa.inputMessageStr)")
                        .foregroundColor(.red)
                }
                
                Divider()
                
                Button("Start decoding") {
                    vc.currentView = .enterDecodePrimesView
                }
            }
        }
    }
}

struct EncodeMessageView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        EncodeMessageView()
        .environmentObject(rsa)
        .environmentObject(vc)
    }
}
