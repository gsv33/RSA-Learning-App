//
//  SplitNumbersView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/31/22.
//

import SwiftUI

struct SplitNumbersView: View {
    @EnvironmentObject var rsa: RSA
    
    let titleText = "Split Numbers"
    
    @State var showInfoSheet = false
    @State var showNextView = false

    @State var elapsedTime = 0
    @State var textOpacity1 = 0.0
    @State var textOpacity2 = 0.0
    @State var textOpacity3 = 0.0
    @State var textOpacity4 = 0.0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // for animations

    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
                .onReceive(timer) { _ in
                    elapsedTime += 1
                    
                    if elapsedTime == 5 {
                        textOpacity2 = 1.0
                    } else if elapsedTime == 10 {
                        textOpacity3 = 1.0
                    } else if elapsedTime == 14 {
                        textOpacity4 = 1.0
                    }
                }
            
            NavigationLink(destination: EncodeMessageView(), isActive: $showNextView) {}
                .isDetailLink(false)
                .toolbar { NavigationToolbar(currentView: .splitNumbersView, titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack{
                ScrollView {
                    Group {
                        Text("Your message in numbers:").padding(.top)
                        TextInScrollView(message: rsa.inputMessageNum)
                            .padding([.leading, .trailing, .bottom])

                        Text("Your encryption key:")
                        DisplayKeyView(exponent: rsa.encryptionKeyE, product: rsa.productOfPrimes, textStyle: .headline)
                    }
                    .onAppear { textOpacity1 = 1.0 }
                    .opacity(textOpacity1)
                    .animation(.easeIn(duration: 1.0), value: textOpacity1)
                    
                    Group {
                        Text("Before we can convert your message, we need to split it up into pieces smaller than the product of your two primes. This lets us properly apply the mathematical transformation to encrypt the message.").padding()
                    }
                    .opacity(textOpacity2)
                    .animation(.easeIn(duration: 1.0), value: textOpacity2)
                    
                    
                    Text("Here is your new message:")
                        .opacity(textOpacity3)
                        .animation(.easeIn(duration: 1.0), value: textOpacity3)
                    

                    TextInScrollView(message: rsa.inputMessageNumSplit)
                        .padding([.leading, .trailing])
                        .opacity(textOpacity3)
                        .animation(.easeIn(duration: 1.0).delay(1), value: textOpacity3)
                    
                    Text("Now, we are finally ready to encode your message.")
                        .padding()
                        .opacity(textOpacity4)
                        .animation(.easeIn(duration: 1.0), value: textOpacity4)
                    
                    Group {
                        MoreInfoButton(
                            showInfoSheet: $showInfoSheet,
                            InfoView: SplitNumbersInfoView()
                        )
                        
                        Button("Encode Message") {
                            rsa.encodeMessage()
                            showNextView = true
                        }
                        .buttonStyle(GenerateRandomPrimesButtonStyle())
                        .padding()
                    }
                    .opacity(textOpacity4)
                    .animation(.easeIn(duration: 1.0).delay(1), value: textOpacity4)
                }
            }
            .monospacedBodyText()
        }
    }
}

struct SplitNumbersView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()

    static var previews: some View {
        NavigationView {
            SplitNumbersView()
                .environmentObject(rsa)
        }
    }
}
