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
    @Binding var hideText: Bool
    @State var showEncodingDetailView = false
    @State var visitedEncodingDetailView = false
    
    var body: some View {
        
        if !hideText {
            Text("Now let's actually do the encoding").padding()
            
            Text("Input numbers: ")
            AlternateTextInScrollView(message: rsa.inputMessageNumSplit)
                .padding(.bottom)
            
            Group {
                Text("Your encryption key:")
                Text("\(String(rsa.encryptionKeyE))")
                    .foregroundColor(Colors.lightBlue) +
                Text("-") +
                Text("\(String(rsa.productOfPrimes))")
                    .foregroundColor(Colors.lightBlue)
            }
            
            Button("Show Encoding Steps") {
                showEncodingDetailView = true
            }
            .sheet(isPresented: $showEncodingDetailView,
                   onDismiss: { visitedEncodingDetailView = true }) {
                EncodingDetailView(title: "Encoding Math",
                                   exp: rsa.encryptionKeyE,
                                   mod: rsa.productOfPrimes,
                                   inputs: rsa.inputMessageNumList,
                                   outputs: rsa.encodedMessageNumList)
                }
           .buttonStyle(MenuButtonStyle())
           .padding()
            
            Group {
                Text("Encoded Numbers:")
                
                AlternateTextInScrollView(message: rsa.encodedMessageNumSplit, textColor: Colors.outputColor)
             
                Button("Next") {
                    withAnimation(.easeIn(duration: 0.50)) {
                        hideText = true
                    }
                }
                .buttonStyle(MenuButtonStyle())
                .padding()
            }
            .opacity(visitedEncodingDetailView ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 0.5), value: visitedEncodingDetailView)
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
        
        EncodeEquation().padding()
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
                .toolbar { NavigationToolbar(currentView: .encodeMessageView, titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack{

                if !hideView2 {
                    EncodeMessageViewPart1(hideText: $hideView1)
                }
                
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
                        hideText: $hideView2
                    )
                    
                    if hideView2 {
                        EncodeMessageViewPart3(showNextView: $showNextView)
                    }
                }
            }.monospacedBodyText()
        }
    }
}

struct EncodingDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    let title: String
    let exp: Int
    let mod: Int
    let inputs: [Number]
    let outputs: [Number]
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                ScrollView {
                    Text(title)
                        .monospacedTitleText()
                        .padding(.bottom, 5)
                    
                    Text("Encryption Key:")
                    EncryptionKey(exponent: exp, product: mod, textStyle: .headline)
                        .padding(.bottom, 5)
                    
                    ScrollView(.horizontal) {
                        Grid(alignment: .leading, horizontalSpacing: 0) {
                            GridRow{
                                Text("Inputs")
                                Text("")
                                Text("")
                                Text("")
                                Text("")
                                Text("Outputs")
                            }
                            
                            ForEach(0 ..< inputs.count) { i in
                                let inputNum = inputs[i].value
                                let outputNum = outputs[i].value
                                
                                GridRow{
                                    Text(inputNum).foregroundColor(Colors.inputColor)
                                    Grid {
                                        GridRow {
                                            Text(String(exp))
                                                .font(.system(.caption, design: .monospaced, weight: .semibold))
                                                .foregroundColor(Colors.lightBlue)
                                        }
                                        GridRow {Text("")}
                                        GridRow {Text("")}
                                    }
                                    
                                    Text(" mod ")
                                    Text(String(mod)).foregroundColor(Colors.lightBlue)
                                    Text(" = ")
                                    Text(outputNum).foregroundColor(Colors.outputColor)
                                }
                            }
                        }
                    }
                    .frame().padding([.leading, .trailing])
                }
                
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
                    .padding()
            }
            .monospacedBodyText()
        }
    }
}

struct EncodeMessageView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()

    static var previews: some View {
//        EncodingDetailView()
//            .environmentObject(rsa)
        
        NavigationView {
            EncodeMessageView()
                .environmentObject(rsa)
        }
    }
}
