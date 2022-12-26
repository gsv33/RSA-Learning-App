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
    
    @State private var showInfoPopover = false
    @State private var showNextView = false
    
    let titleText = "Encode Message"
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: EnterDecodePrimesView(), isActive: $showNextView) {}
                .toolbar { NavigationToolbar(titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack{
                Group {
                    Text("First, we take your input numbers: ")
                    HStack {
                        ForEach(rsa.inputMessageNumList) { number in
                            Text(number.value)
                        }
                    }
                                        
                    Text("Then we use your public key and modular exponentiation to compute")
                    
                    EncodedMessageOutputList(
                        inputs: rsa.inputMessageNumList,
                        outputs: rsa.encodedMessageNumList,
                        animationFinished: $animationFinished
                    )
                    
                    Button(action: {
                        showInfoPopover = true
                    }) {
                        Label("More Info", systemImage: "info.square")
                    }
                    .popover(isPresented: $showInfoPopover) { EncodeMessageInfoView() }
                    .monospacedBodyText()
                    .padding(.bottom)
                }
                
//                if animationFinished {
                    Text("Putting it all together, this is your encoded message! Do you think you could possibly guess what it corresponds to?").padding()
                    
                    Text(rsa.encodedMessageNum)
                    
                    Button(showMessage ? "Hide original message" : "HINT: Reveal Original message") {
                        showMessage.toggle()
                    }
                    
                    if showMessage {
                        Text("\(rsa.inputMessageEng)")
                            .foregroundColor(.red)
                    }

                    Text("Now that the message is encoded, we'll learn how to reverse the process, and convert your encoding back into the original message.").padding()
                
                    Button("Start decoding") {
                        vc.currentView = .enterDecodePrimesView
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .font(.system(.title3, design: .monospaced))
//                }
            }.monospacedBodyText()
        }
    }
}

struct EncodeMessageView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        NavigationView {
            EncodeMessageView()
                .environmentObject(rsa)
                .environmentObject(vc)
        }
    }
}
