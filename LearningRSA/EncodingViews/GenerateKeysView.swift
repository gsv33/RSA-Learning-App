//
//  GenerateKeysView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/1/22.
//

import SwiftUI

struct GenerateKeysView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    let titleText = "Create Public Key"
    
    @State var showInfoPopover = false
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
            backgroundColor.ignoresSafeArea()
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
                    .toolbar { NavigationToolbar(titleText: titleText) }
                    .navigationBarBackButtonHidden()
                    .navigationBarTitleDisplayMode(.inline)

                ScrollView {
                    Group {
                        Text("Your public key is what other people use to send you encrypted messages. It's used to \"lock\" a message before sending it to you.")
                            .padding([.top,.leading,.trailing])
                        
                        Text("It's made up of two parts.").padding([.top,.leading,.trailing])
                    }
                    .onAppear { textOpacity1 = 1.0 }
                    .opacity(textOpacity1)
                    .animation(.easeIn(duration: 1.0), value: textOpacity1)
                    
                    Group {
                        Text("The first part is the product of your two prime numbers, p and q.").padding()
                        
                        Text("\(String(rsa.prime1))").foregroundColor(inputColor) +
                        Text(" x ") +
                        Text("\(String(rsa.prime2))").foregroundColor(inputColor) +
                        Text(" = ") +
                        Text("\(String(rsa.productOfPrimes))").foregroundColor(outputColor)
                    }
                    .opacity(textOpacity2)
                    .animation(.easeIn(duration: 1.0), value: textOpacity2)
                    
                    Group {
                        Text("The second part is a number relatively prime to \n(p - 1) x (q - 1). This means the two numbers have no common factors.")
                            .padding()
                    }
                    .opacity(textOpacity3)
                    .animation(.easeIn(duration: 1.0), value: textOpacity3)
                    
                    Group {
                        Text("\(String(rsa.prime1 - 1))").foregroundColor(inputColor) +
                        Text(" x ") +
                        Text("\(String(rsa.prime2 - 1))").foregroundColor(inputColor) +
                        Text(" = ") +
                        Text("\(String(rsa.encodePhi))").foregroundColor(outputColor)
                        
                        Text("")
                    
                        Text("\(String(rsa.encodePhi))").foregroundColor(inputColor) +
                        Text(" is relatively prime to ") +
                        Text("\(String(rsa.publicKeyK))").foregroundColor(outputColor)
                    }
                    .opacity(textOpacity4)
                    .animation(.easeIn(duration: 1.0), value: textOpacity4)

                    Group {
                        Text("").padding(.top)
                        
                        Text("Your public key is")
                        Text("\(String(rsa.productOfPrimes))")
                            .font(.system(.title2, weight: .semibold))
                            .foregroundColor(outputColor) +
                        Text("-") +
                        Text("\(String(rsa.publicKeyK))")
                            .font(.system(.title2, weight: .semibold))
                            .foregroundColor(outputColor)
                        
                        Button(action: {
                            showInfoPopover = true
                        }) {
                            Label("More Info", systemImage: "info.square")
                        }
                        .popover(isPresented: $showInfoPopover) { GeneratePublicKeyInfoView() }
                        .monospacedBodyText()
                        .padding()
                        
                        
                        Button("Next") {
                            showNextView = true
                        }
                        .buttonStyle(MenuButtonStyle())
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
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        NavigationView {
            GenerateKeysView()
                .environmentObject(rsa)
                .environmentObject(vc)
        }
    }
}
