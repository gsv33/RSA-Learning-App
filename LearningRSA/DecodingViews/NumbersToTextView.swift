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
            
            VStack{
                if currSection == 0 {
                    Text("The last step is to convert your decoded message back into English. We use the same mapping as we did last time.").padding()
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
                        OutputTextView(text: rsa.realDecodedMessageNum)
                    }
                    
                    Text("Output Message:")
                    OutputTextView(text: rsa.realDecodedMessageEng)
                    
                }
                .opacity(revealRealMessage ? 1.0 : 0.1)
                .animation(.default, value: revealRealMessage)

                if currSection == 0 {
                    Button("Reveal Message") {
                        revealRealMessage = true
                    }
                    .buttonStyle(MenuButtonStyle())
                    .opacity(revealRealMessage ? 0.4 : 1.0)
                    .animation(.default, value: revealRealMessage)
                    
                    Button("Next") {
                        withAnimation(.easeIn) {
                            currSection = 1
                        }
                    }
                    .buttonStyle(MenuButtonStyle())
                    .opacity(revealRealMessage ? 1.0 : 0.0)
                    .animation(.default, value: revealRealMessage)
                    .padding()
                    
                }

                
                if currSection == 1 {
                    Text("Now we'll see what a hacker might have gotten using the wrong primes and wrong decoded message.").padding([.leading, .trailing, .bottom])
                    
                    Group {
                        Text("Decoded Message:")
                        OutputTextView(text: rsa.fakeDecodedMessageNum)

                        Text("Output Message:")
                        OutputTextView(text: rsa.fakeDecodedMessageEng)

                    }
                    .opacity(revealFakeMessage ? 1.0 : 0.1)
                    .animation(.default, value: revealFakeMessage)

                    Button("Reveal Message") {
                        revealFakeMessage = true
                    }
                    .buttonStyle(MenuButtonStyle())
                    .opacity(revealFakeMessage ? 0.4 : 1.0)
                    .animation(.default, value: revealFakeMessage)

                    Group {
                        MoreInfoButton(showInfoSheet: $showInfoSheet, InfoView: NumbersToTextInfoView())
                            .padding()
                        
                        Button("Next") {
                            showNextView = true
                        }
                        .buttonStyle(MenuButtonStyle())
                    }
                    .opacity(revealFakeMessage ? 1.0 : 0.0)
                    .animation(.default, value: revealFakeMessage)
                }
            }
            .monospacedBodyText()
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
