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
    
    let titleText = "Message Encoding"
    
    @State var showMappingPopover = false
    @State var showInfoPopover = false
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack{
                Text("First, we encode the message by converting each letter to a different number.")
                    .padding(.bottom)

                Button("See how each letter is converted to a number") {
                    showMappingPopover = true
                }
                .popover(isPresented: $showMappingPopover) { MappingView() }
                .buttonStyle(MenuButtonStyle())
                .padding(.bottom)

                Button(action: {
                    showInfoPopover = true
                }) {
                    Label("More Info", systemImage: "info.square")
                }
                .popover(isPresented: $showInfoPopover) { MessageEncodingInfoView() }
                .monospacedBodyText()
                                
                Divider()
                    .frame(height: 1)
                    .overlay(.white)
                    .padding([.top, .bottom])
                
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
                
                
                Text("Next, create your secret key.")
                    .padding(.bottom)

                NavigationLink(destination: EnterEncodePrimesView()) {
                    Text("Create secret key")
                }
                .buttonStyle(MenuButtonStyle())
                .toolbar { NavigationToolbar(titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline) // needed to remove the space reserved for the nav title
            }
            .monospacedInfoText()
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
