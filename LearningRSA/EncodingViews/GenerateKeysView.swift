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
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack {
                NavigationLink(destination: SplitNumbersView(), isActive: $showNextView) {}
                    .toolbar { NavigationToolbar(titleText: titleText) }
                    .navigationBarBackButtonHidden()
                    .navigationBarTitleDisplayMode(.inline)

                ScrollView {
                    Group {
                        Text("Your public key is what other people use to send you encrypted messages. It's used to \"lock\" a message before sending it to you.")
                            .padding()
                        
                        Text("It's made up of two parts.").padding()
                        
                        Text("The first part is the product of your two prime numbers, p and q.").padding()
                        
                        Text("\(String(rsa.prime1))").foregroundColor(inputColor) +
                        Text(" x ") +
                        Text("\(String(rsa.prime2))").foregroundColor(inputColor) +
                        Text(" = ") +
                        Text("\(String(rsa.productOfPrimes))").foregroundColor(outputColor)
                    }
                    
                    Group {
                        Text("The second part is a number relatively prime to \n(p - 1) x (q - 1). This means the two numbers have no common factors.")
                            .padding()
                        
                        Text("\(String(rsa.prime1 - 1))").foregroundColor(inputColor) +
                        Text(" x ") +
                        Text("\(String(rsa.prime2 - 1))").foregroundColor(inputColor) +
                        Text(" = ") +
                        Text("\(String(rsa.encodePhi))").foregroundColor(outputColor) +
                        Text("\n")
                        
                        Text("\(String(rsa.encodePhi))").foregroundColor(inputColor) +
                        Text(" is relatively prime to ") +
                        Text("\(String(rsa.publicKeyK))\n\n").foregroundColor(outputColor)
                    }

    
                    Text("Your public key is ") +
                    Text("\(String(rsa.encodePhi))").foregroundColor(outputColor) +
                    Text("-") +
                    Text("\(String(rsa.publicKeyK))").foregroundColor(outputColor)
                    
                    Button(action: {
                        showInfoPopover = true
                    }) {
                        Label("More Info", systemImage: "info.square")
                    }
                    .popover(isPresented: $showInfoPopover) { }
                    .monospacedBodyText()
                    .padding()

                    
                    Button("Next") {
                        showNextView = true
                    }
                    .buttonStyle(MenuButtonStyle())
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
