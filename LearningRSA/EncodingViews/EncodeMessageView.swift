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

        AlternateTextInScrollView(message: rsa.encodedMessageNum, textColor: Colors.outputColor, maxHeight: .infinity)
        .padding([.leading, .trailing, .bottom])
        
        Text("This sequence of numbers corresponds exactly to your original message: ")
            .padding([.leading, .trailing, .bottom])

        AlternateTextInScrollView(message: rsa.inputMessageEng, textColor: .red, maxHeight: .infinity)
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
            Text("Now let's encode your message!").padding([.leading, .trailing, .bottom])
            
            Text("Input Numbers: ")
            AlternateTextInScrollView(message: rsa.inputMessageNumSplit, maxHeight: .infinity)
                .padding([.leading, .trailing, .bottom])
            
            Text("Your encryption key:")
            DisplayKeyView(exponent: rsa.encryptionKeyE, product: rsa.productOfPrimes, textStyle: .headline)
            
            Button("Show Encoding Math") {
                showEncodingDetailView = true
            }
            .sheet(isPresented: $showEncodingDetailView,
                   onDismiss: { visitedEncodingDetailView = true }) {
                EncodingDetailView(title: "Encoding Math",
                                   subtitle: "Encryption Key",
                                   exp: rsa.encryptionKeyE,
                                   mod: rsa.productOfPrimes,
                                   inputs: rsa.inputMessageNumList,
                                   outputs: rsa.encodedMessageNumList)
                }
           .purpleButtonStyle()
           .padding()
            
            Group {
                Text("Encoded Numbers:")
                
                AlternateTextInScrollView(message: rsa.encodedMessageNumSplit, textColor: Colors.outputColor, maxHeight: .infinity)
                    .padding([.leading, .trailing])
             
                Button("Next") {
                    withAnimation(.easeIn(duration: 0.50)) {
                        hideText = true
                    }
                }
                .purpleButtonStyle()
                .padding()
            }
            .opacity(visitedEncodingDetailView ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 0.5), value: visitedEncodingDetailView)
        }
    }
}

struct EncodeMessageViewPart1: View {
    @EnvironmentObject var rsa: RSA
    @Binding var hideText: Bool
    
    var body: some View {
        
        if hideText == false {
            Text("In order to encode your message, we use modular exponentiation.")
                .padding()
            
            Text("We take each of your input numbers, X, raise it to the power, E, and take the remainder with respect to M, where M and E are the two parts of the encryption key we calculated earlier.")
                .padding([.leading, .trailing, .bottom])
            
            Text("Given your encryption key:")
            DisplayKeyView(exponent: rsa.encryptionKeyE, product: rsa.productOfPrimes, textStyle: .headline)
                .padding(.bottom)
            
            Text("E = ") + Text(String(rsa.encryptionKeyE)).foregroundColor(Colors.outputColor)
            (Text("M = ") + Text(String(rsa.productOfPrimes)).foregroundColor(Colors.outputColor))
                .padding(.bottom)

            Text("Mathematically, this equation is: ").padding([.leading, .trailing])
        }
        
        EncodeEquation().padding()
        
        if hideText == false {
            Button("Next") {
                withAnimation(.easeIn(duration: 0.50)) {
                    hideText = true
                }
            }
            .purpleButtonStyle()
            .padding()
        }
    }
}

struct EncodeMessageView: View {
    
    @State private var showNextView = false
    
    @State var hideView1 = false
    @State var hideView2 = false
    
    let titleText = "Message Encoding"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: EnterDecodePrimesView(), isActive: $showNextView) {}
                .isDetailLink(false)
                .toolbar { NavigationToolbar(currentView: .encodeMessageView, titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack {
                if !hideView2 {
                    EncodeMessageViewPart1(hideText: $hideView1)
                }
                
                if hideView1 {
                    EncodeMessageViewPart2(
                        hideText: $hideView2
                    )
                    
                    if hideView2 {
                        EncodeMessageViewPart3(showNextView: $showNextView)
                    }
                }
            }
            .monospacedBodyText()
        }
    }
}

struct EncodingDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    let title: String
    let subtitle: String
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
                        .padding([.top, .bottom], 5)
                    
                    Text(subtitle)
                    DisplayKeyView(exponent: exp, product: mod, textStyle: .headline)
                        .padding(.bottom, 5)
                    
                    Grid(alignment: .leading, horizontalSpacing: 0) {
                        GridRow{
                            Text("Inputs")
                                .minimumScaleFactor(0.5)
                                .gridColumnAlignment(.trailing)
                            Text("")
                            Text("")
                            Text("")
                            Text("")
                            Text("Outputs")
                                .minimumScaleFactor(0.5)
                        }
                        
                        ForEach(0 ..< inputs.count) { i in
                            let inputNum = inputs[i].value
                            let outputNum = outputs[i].value
                            
                            GridRow{
                                Text(inputNum).foregroundColor(Colors.inputColor).minimumScaleFactor(0.5)
                                Grid {
                                    GridRow {
                                        Text(String(exp))
                                            .font(.system(.caption, design: .monospaced, weight: .semibold))
                                            .foregroundColor(Colors.lightBlue)
                                    }
                                    GridRow {Text("")}
                                    GridRow {Text("")}
                                }
                                
                                Text(" mod ").minimumScaleFactor(0.5)
                                Text(String(mod)).foregroundColor(Colors.lightBlue).minimumScaleFactor(0.5)
                                Text(" = ").minimumScaleFactor(0.5)
                                Text(outputNum).foregroundColor(Colors.outputColor).minimumScaleFactor(0.5)
                            }
                        }
                    }
                    .lineLimit(1)
                    .padding([.leading, .trailing], 5)
                }
                
                Button("Dismiss") { dismiss() }
                    .purpleButtonStyle()
                    .padding()
            }
            .monospacedBodyText()
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

        
//        EncodingDetailView(title: "Encoding Test",
//                           subtitle: "Encryption Key",
//                           exp: 947,
//                           mod: 378857,
//                           inputs: [Number(value: "345"),Number(value: "345"),Number(value: "345"),Number(value: "12345"),Number(value: "12345")],
//                           outputs: [Number(value: "12345"),Number(value: "12345"),Number(value: "12345"),Number(value: "12345"),Number(value: "12345")])
//            .environmentObject(rsa)
//
//        EncodingDetailView(title: "Decoding Math",
//                           subtitle: "Decryption Key",
//                           exp: rsa.realDecryptionKeyD,
//                           mod: rsa.productOfPrimes,
//                           inputs: rsa.encodedMessageNumList,
//                           outputs: rsa.realDecodedMessageNumList)
//        .environmentObject(rsa)
        
//        NavigationView {
//            ZStack {
//                Colors.backgroundColor.ignoresSafeArea()
//                VStack {
//                    EncodeMessageViewPart3(showNextView: .constant(false))
//                        .environmentObject(rsa)
//                }.monospacedBodyText()
//            }
//        }
    }
}
