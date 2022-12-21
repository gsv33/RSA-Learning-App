//
//  MessageToNumbersView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI

// Shows the entire character to number mapping used as a popover
struct MappingView: View {
    @Environment(\.dismiss) var dismiss
    
    var charToNumArr = CharacterConverter.charToNumArray
    let columns = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            VStack {
                Text("Character to Number Mapping")
                    .monospacedTitleText().padding(5)
                                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(0 ..< charToNumArr.count) { i in
                            
                            if charToNumArr[i].character == " " { // separate to show space bar as an image
                                Text(Image(systemName: "space"))
                                    .foregroundColor(inputColor) +
                                Text(" = ")
                                    .font(.system(.headline, design: .rounded, weight: .semibold)) +
                                Text(charToNumArr[i].number)
                                    .foregroundColor(outputColor)
                            }
                            else {
                                Text(String(charToNumArr[i].character))
                                    .foregroundColor(inputColor) +
                                Text(" = ") +
                                Text(charToNumArr[i].number)
                                    .foregroundColor(outputColor)
                            }
                        }
                    }
                }
                .foregroundColor(.white)
                .font(.system(.headline, design: .monospaced, weight: .semibold))

                
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
            }
        }.foregroundColor(textColor)
    }
}

struct MessageToNumbersView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    let titleText = "Message Encoding"
    
    @State var showMappingPopover = false
    @State var showInfoPopover = false
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
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
