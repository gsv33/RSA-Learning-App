//
//  GenerateKeysView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/1/22.
//

import SwiftUI

struct GenerateKeysView: View {
    @EnvironmentObject var rsa: RSA
    
    let titleText = "Encryption Key"
    
    @State var showInfoSheet = false
    @State var showNextView = false
    
    @State var elapsedTime = 0
    @State var textOpacity1 = 0.0
    @State var textOpacity2 = 0.0
    @State var textOpacity3 = 0.0
    @State var textOpacity4 = 0.0
    @State var textOpacity5 = 0.0

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
                    } else if elapsedTime == 15 {
                        textOpacity4 = 1.0
                    } else if elapsedTime == 20 {
                        textOpacity5 = 1.0
                    }
                }
            
            VStack {
                NavigationLink(destination: SplitNumbersView(), isActive: $showNextView) {}
                    .isDetailLink(false)
                    .toolbar { NavigationToolbar(currentView: .generateKeysView, titleText: titleText) }
                    .navigationBarBackButtonHidden()
                    .navigationBarTitleDisplayMode(.inline)

                ScrollView {
                    Group {
                        Text("Your encryption key is what other people use to send you encrypted messages. It's used to \"lock\" a message before sending it to you.")
                            .padding([.top,.leading,.trailing])
                        
                        Text("It's made up of two parts.").padding([.top,.leading,.trailing])
                    }
                    .onAppear { textOpacity1 = 1.0 }
                    .opacity(textOpacity1)
                    .animation(.easeIn(duration: 1.0), value: textOpacity1)
                    
                    Group {
                        Text("The first part is the product of your two prime numbers, P and Q.").padding()
                        
                        Text("\(String(rsa.prime1))").foregroundColor(Colors.inputColor) +
                        Text(" x ") +
                        Text("\(String(rsa.prime2))").foregroundColor(Colors.inputColor) +
                        Text(" = ") +
                        Text("\(String(rsa.productOfPrimes))").foregroundColor(Colors.outputColor)
                    }
                    .opacity(textOpacity2)
                    .animation(.easeIn(duration: 1.0), value: textOpacity2)
                    
                    Group {
                        Text("The second part is a number relatively prime to \n(P - 1) x (Q - 1). This means the two numbers have no common factors.")
                            .padding()
                    }
                    .opacity(textOpacity3)
                    .animation(.easeIn(duration: 1.0), value: textOpacity3)
                    
                    Group {
                        Text("\(String(rsa.prime1 - 1))").foregroundColor(Colors.inputColor) +
                        Text(" x ") +
                        Text("\(String(rsa.prime2 - 1))").foregroundColor(Colors.inputColor) +
                        Text(" = ") +
                        Text("\(String(rsa.encodePhi))").foregroundColor(Colors.outputColor)
                        
                        (Text("\(String(rsa.encodePhi))").foregroundColor(Colors.inputColor) +
                        Text(" is relatively prime to ") +
                        Text("\(String(rsa.encryptionKeyE))").foregroundColor(Colors.outputColor))
                        .padding(.top)
                    }
                    .opacity(textOpacity4)
                    .animation(.easeIn(duration: 1.0), value: textOpacity4)

                    Group {
                        
                        Text("Your encryption key is").padding(.top)
                        DisplayKeyView(exponent: rsa.encryptionKeyE, product: rsa.productOfPrimes)
                        
                        MoreInfoButton(
                            showInfoSheet: $showInfoSheet,
                            InfoView: GeneratePublicKeyInfoView()
                        ).padding()
                        
                        Button("Next") {
                            showNextView = true
                        }
                        .buttonStyle(MenuButtonStyle())
                        .padding(.bottom)
                    }
                    .opacity(textOpacity5)
                    .animation(.easeIn(duration: 1.0), value: textOpacity5)

                }
            }
            .monospacedBodyText()
        }
    }
}

struct GenerateKeysView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()

    static var previews: some View {
        NavigationView {
            GenerateKeysView()
                .environmentObject(rsa)
        }
    }
}
