//
//  MessageToNumbersView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI

struct MessageToNumbersView: View {
    @EnvironmentObject var rsa: RSA
    
    let titleText = "Number Conversion"
    
    @State var showMappingSheet = false
    @State var showInfoSheet = false
    @State var showNextView = false
    @State var showMessages = false
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: EnterEncodePrimesView(), isActive: $showNextView) {}
                .isDetailLink(false)
                .toolbar { NavigationToolbar(currentView: .messageToNumbersView, titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline) // needed to remove the space reserved for the nav title
            
//            GeometryReader { geometry in
//                ScrollView {
                    VStack {
                        
                        if !showMessages {
                            Text("First, we convert each character in the message to a different number.")
                                .padding(.bottom)
                        }
                        
                        Button("Show number to letter mapping") {
                            showMappingSheet = true
                        }
                        .sheet(isPresented: $showMappingSheet) { MappingView() }
                        .foregroundColor(Colors.outputColor)
                        .padding(.bottom)
                        
                        if !showMessages {
                            Button("Convert message to numbers") {
                                withAnimation {
                                    showMessages = true
                                }
                            }
                            .purpleButtonStyle()
                            .padding()
                        }
                        
                        if showMessages {
                            Divider()
                                .frame(height: 1)
                                .overlay(.white)
                                .padding([.bottom])
                            
                            Text("Input Message:")
                            TextInScrollView(message: rsa.inputMessageEng)
                            
                            Text("Converted Message:").padding(.top)
                            TextInScrollView(message: rsa.inputMessageNum)
                            
                            MoreInfoButton(showInfoSheet: $showInfoSheet, InfoView: MessageEncodingInfoView())
                                .padding([.top, .bottom])
                            
                            Text("Next, we'll choose prime numbers that will be used to secure your message.")
                                .padding(.bottom)
                            
                            Button("Choose Prime Numbers") {
                                showNextView = true
                            }
                            .purpleButtonStyle()
                        }
                    }
//                    .frame(minHeight: geometry.size.height)
                    .monospacedBodyText()
                    .padding()
//                }
//            }
        }
    }
}

struct MessageToNumbersView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()

    static var previews: some View {
        NavigationView {
            MessageToNumbersView()
                .environmentObject(rsa)            
        }
    }
}
