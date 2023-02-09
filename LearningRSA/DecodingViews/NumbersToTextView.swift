//
//  NumbersToTextView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/2/22.
//
//  Converts the decoded message back to text

import SwiftUI

// Displays black text on a white background inside a scroll view
// Used for showing input and output text
// e.g. input numbers and output message
struct OutputTextView: View {
    let text: String
    
    var body: some View {
        ScrollView {
            Text(text)
                .foregroundColor(.black)
                .font(.system(.headline, design: .monospaced, weight: .semibold))
                .padding()
                .background(.white)
                .cornerRadius(10)
        }
        .frame(maxHeight: 75)
    }
}

struct NumbersToTextView: View {
    @EnvironmentObject var rsa: RSA
    
    @State private var showNextView = false
    @State private var showInfoSheet = false
    @State private var showMappingSheet = false

    @State private var revealRealMessage = false
    @State private var revealFakeMessage = false
    @State private var currSection = 0 // controls which section of the view is being displayed
    
    var titleText = "Numbers to Text"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: ConclusionView(), isActive: $showNextView) {}
                .isDetailLink(false)
                .toolbar { NavigationToolbar(currentView: .numbersToTextView, titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            GeometryReader { geometry in
                ScrollView {
                    
                    VStack{
                        if currSection == 0 {
                            Text("The last step is to convert your decoded message back into text. We use the same mapping as we did last time.")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                        }
                        
                        Button("Show number to letter mapping") {
                            showMappingSheet = true
                        }
                        .sheet(isPresented: $showMappingSheet) { MappingView() }
                        .foregroundColor(Colors.outputColor)
                        .padding()
                        
                        Group {
                            if currSection == 0 {
                                Text("Decoded Message:")
                                TextInScrollView(message: rsa.realDecodedMessageNum)
                                    .padding([.leading, .trailing, .bottom])
                                
                                Text("Output Message:")
                                TextInScrollView(message: rsa.realDecodedMessageEng)
                                    .padding([.leading, .trailing])
                            }
                        }
                        .opacity(revealRealMessage ? 1.0 : 0.1)
                        .animation(.default, value: revealRealMessage)
                        
                        if currSection == 0 {
                            Button("Reveal Message") {
                                revealRealMessage = true
                            }
                            .purpleButtonStyle()
                            .opacity(revealRealMessage ? 0.4 : 1.0)
                            .animation(.default, value: revealRealMessage)
                            .padding()
                            
                            Button("Next") {
                                withAnimation(.easeIn) {
                                    currSection = 1
                                }
                            }
                            .purpleButtonStyle()
                            .opacity(revealRealMessage ? 1.0 : 0.0)
                            .animation(.default, value: revealRealMessage)
                            .padding(.bottom)
                        }
                        
                        
                        if currSection == 1 {
                            Text("Now here's what a hacker might have gotten using the wrong primes and wrong decoded message.")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding([.leading, .trailing, .bottom])
                            
                            Group {
                                Text("Decoded Message:")
                                TextInScrollView(message: rsa.fakeDecodedMessageNum)
                                    .padding([.leading, .trailing])
                                
                                Text("Output Message:")
                                    .padding(.top)
                                TextInScrollView(message: rsa.fakeDecodedMessageEng)
                                    .padding([.leading, .trailing])
                                
                            }
                            .opacity(revealFakeMessage ? 1.0 : 0.1)
                            .animation(.default, value: revealFakeMessage)
                            
                            Button("Reveal Message") {
                                revealFakeMessage = true
                            }
                            .purpleButtonStyle()
                            .opacity(revealFakeMessage ? 0.4 : 1.0)
                            .animation(.default, value: revealFakeMessage)
                            .padding(.top)
                            
                            Group {
                                MoreInfoButton(showInfoSheet: $showInfoSheet, InfoView: NumbersToTextInfoView())
                                    .padding()
                                
                                Button("Next") {
                                    showNextView = true
                                }
                                .purpleButtonStyle()
                                .padding(.bottom)
                            }
                            .opacity(revealFakeMessage ? 1.0 : 0.0)
                            .animation(.default, value: revealFakeMessage)
                        }
                    }
                    .frame(minHeight: geometry.size.height)
//                    .frame(width: geometry.size.width)
                    .monospacedBodyText()
                }
            }
        }
    }
}


struct NumbersToTextView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()

    static var previews: some View {
        NavigationView {
            NumbersToTextView()
                .environmentObject(rsa)
        }
    }
}
