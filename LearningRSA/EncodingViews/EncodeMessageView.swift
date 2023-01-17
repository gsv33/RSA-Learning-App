//
//  EncodeMessageView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/1/22.
//

import SwiftUI

struct EncodeMessageViewPart3: View {
    @EnvironmentObject var rsa: RSA
    @State private var showInfoSheet = false
    @Binding var showNextView: Bool
    
    var body: some View {
  
        Text("Putting it all together, here's your encoded message:").padding()

        Text(rsa.encodedMessageNum).foregroundColor(Colors.outputColor)
            .padding([.leading, .trailing, .bottom])

        Text("This sequence of numbers corresponds exactly to your original message: ")
            .padding([.leading, .trailing, .bottom])
        
        Text("\(rsa.inputMessageEng)")
                .foregroundColor(.red)
                .padding([.leading, .trailing, .bottom])
        
        Text("Now that the message is encoded, we'll learn how to reverse the process and decode your message.")
            .padding([.leading, .trailing, .bottom])

        MoreInfoButton(
            showInfoSheet: $showInfoSheet,
            InfoView: EncodeMessageInfoView()
        )
        
        Button("Start decoding") {
            showNextView = true
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
        .font(.system(.title3, design: .monospaced))
        .padding()
    }
}

struct EncodeMessageViewPart2: View {
    @EnvironmentObject var rsa: RSA
    @Binding var animationFinished: Bool
    @Binding var hideText: Bool
    @State var startAnimation = false
    
    var body: some View {
        
        if hideText == false {
            Text("Now let's actually do the encoding").padding()
            
            Text("Input numbers: ")
            HStack {
                ForEach(rsa.inputMessageNumList) { number in
                    Text(number.value).foregroundColor(Colors.inputColor)
                }
            }.padding(.bottom)
            
            Group {
                Text("Public key:")
                Text("\(String(rsa.encryptionKeyE))")
                    .foregroundColor(Colors.lightBlue) +
                Text("-") +
                Text("\(String(rsa.productOfPrimes))")
                    .foregroundColor(Colors.lightBlue)
            }
            
            if !startAnimation {
                Button("Begin Encoding") {
                    withAnimation(.easeIn) {
                        startAnimation = true
                    }
                }
                .buttonStyle(MenuButtonStyle())
                .padding()
            }
            
            if startAnimation {
                Text("Encoding:").padding(.top)
            }
        }

        if startAnimation {
            EncodedMessageOutputList(
                inputs: rsa.inputMessageNumList,
                outputs: rsa.encodedMessageNumList,
                exponent: String(rsa.encryptionKeyE),
                modulus: String(rsa.productOfPrimes),
                animationFinished: $animationFinished,
                hideText: $hideText
            )
        }
    }
}

struct EncodeMessageViewPart1: View {
    
    @Binding var hideText: Bool
    
    var body: some View {
        
        if hideText == false {
            Text("Now, we can finally encode your message. To do this, we use modular exponentiation.")
                .padding()
            
            Text("We take each of your input numbers, X, raise it to the power, E, and take the remainder with respect to M, where M and E are the two parts of the public key we computed earlier.")
                .padding([.leading, .trailing, .bottom])
            
            Text("Mathematically, this equation is: ")
        }
        
        EncodeEquation()
            .padding()
        
    }
}

struct EncodeMessageView: View {
    @EnvironmentObject var rsa: RSA
    
    @State private var animationFinished = false    
    @State private var showNextView = false
    
    @State var hideView1 = false
    @State var hideView2 = false
    
    let titleText = "Encode Message"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: EnterDecodePrimesView(), isActive: $showNextView) {}
                .isDetailLink(false)
                .toolbar { NavigationToolbar(titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack{

                EncodeMessageViewPart1(hideText: $hideView1)
                
                if !hideView1 {
                    Button("Next") {
                        withAnimation(.easeIn(duration: 0.50)) {
                            hideView1 = true
                        }
                    }
                    .buttonStyle(MenuButtonStyle())
                    .padding()
                } else {
                    EncodeMessageViewPart2(
                        animationFinished: $animationFinished,
                        hideText: $hideView2
                    )
                    
                    if !hideView2 {
                        Button("Next") {
                            withAnimation(.easeIn(duration: 0.50)) {
                                hideView2 = true
                            }
                        }
                        .buttonStyle(MenuButtonStyle())
                        .opacity(animationFinished ? 1.0 : 0.0)
                        .padding()
                        .animation(.default, value: animationFinished)
                        
                    } else {
                        EncodeMessageViewPart3(showNextView: $showNextView)
                    }
                }
            }.monospacedBodyText()
        }
    }
}

struct EncodeMessageView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()

    static var previews: some View {
        NavigationView {
            EncodeMessageView()
                .environmentObject(rsa)
        }
    }
}
