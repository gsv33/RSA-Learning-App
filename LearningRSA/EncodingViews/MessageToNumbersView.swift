//
//  MessageToNumbersView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI

struct MessageToNumbersView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    let titleText = "Number Conversion"
    
    @State var showMappingPopover = false
    @State var showInfoPopover = false
    @State var showNextView = false
    @State var showMessages = false
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: EnterEncodePrimesView(), isActive: $showNextView) {}
            .toolbar { NavigationToolbar(titleText: titleText) }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline) // needed to remove the space reserved for the nav title
            
            VStack{
                Text("First, we convert each character in the message to a different number.")
                    .padding(.bottom)

                
                Button("Show number to letter mapping") {
                    showMappingPopover = true
                }
                .popover(isPresented: $showMappingPopover) { MappingView() }
                .foregroundColor(Colors.outputColor)
                .padding(.bottom)
                
                if !showMessages {
                    Button("Show message conversion") {
                        withAnimation {
                            showMessages = true
                        }
                    }
                    .buttonStyle(MenuButtonStyle())
                    .padding()
                }
                
                if showMessages {
                    Divider()
                        .frame(height: 1)
                        .overlay(.white)
                        .padding([.bottom])
                    
                    Text("Input Message:")
                    ScrollView {
                        Text(rsa.inputMessageEng)
                            .foregroundColor(.black)
                            .font(.system(.headline, design: .monospaced, weight: .semibold))
                            .padding()
                            .background(.white)
                            .cornerRadius(10)
                    }
                    .frame(maxHeight: 100)
                    
                    Text("Encoded Message:")
                    ScrollView {
                        Text(rsa.inputMessageNum)
                            .foregroundColor(.black)
                            .font(.system(.headline, design: .monospaced, weight: .semibold))
                            .padding()
                            .background(.white)
                            .cornerRadius(10)
                    }
                    .frame(maxHeight: 100)
                    
                    MoreInfoButton(showInfoPopover: $showInfoPopover, InfoView: MessageEncodingInfoView())
                        .padding(.bottom)

                    Text("Next, we'll move on to choosing prime numbers that will be used to secure your message.")
                        .padding(.bottom)
                                        
                    Button("Choose Prime Numbers") {
                        showNextView = true
                    }
                    .buttonStyle(MenuButtonStyle())
                }
            }
            .monospacedBodyText()
            .padding()
        }
    }
}

struct MessageToNumbersView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        NavigationView {
            MessageToNumbersView()
                .environmentObject(rsa)
                .environmentObject(vc)
            
        }
    }
}
