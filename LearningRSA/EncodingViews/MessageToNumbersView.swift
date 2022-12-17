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
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            VStack {
                Text("Character to Number Mapping")
                    .monospacedTitleText().padding()
                
                Text("This is how each character is converted to a number.")
                    .monospacedBodyText().padding()
                
                ScrollView {
                    Grid {
                        Group {
                            GridRow {
                                ForEach(0 ..< 10) { i in
                                    Text(String(charToNumArr[i].char))
                                }
                            }
                            Divider()
                            GridRow {
                                ForEach(0 ..< 10) { i in
                                    Text(String(charToNumArr[i].number))
                                }
                            }
                            Divider()
                            GridRow {
                                ForEach(10 ..< 20) { i in
                                    Text(String(charToNumArr[i].char))
                                }
                            }
                            Divider()
                            GridRow {
                                ForEach(10 ..< 20) { i in
                                    Text(String(charToNumArr[i].number))
                                }
                            }
                        }
                        Group {
                            Divider()
                            GridRow {
                                ForEach(20 ..< 26) { i in
                                    Text(String(charToNumArr[i].char))
                                }
                            }
                            Divider()
                            GridRow {
                                ForEach(20 ..< 26) { i in
                                    Text(String(charToNumArr[i].number))
                                }
                            }
                        }
                    }.padding()
                }
                
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
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack{
                Text("Next we'll take your message and convert it to numbers. This isn't part of the algorithm, its just easier to work with numbers than letters.").font(.system(.headline, design: .monospaced))
                
                Group {
                    Divider()
                    Text("Here's what you entered:")
                    Text(rsa.inputMessageEng)
                    Divider()
                }
                                
                Group {
                    Divider()
                    Text("This is the output:")
                    Text(rsa.inputMessageNum)
                    Divider()
                }
                
                Button("See Mapping") {
                    showMappingPopover = true
                }
                .popover(isPresented: $showMappingPopover) {
                    MappingView()
                }.buttonStyle(MenuButtonStyle())
                
                NavigationLink(destination: EnterEncodePrimesView()) {
                    Text("Enter primes to encode")
                }
                .buttonStyle(MenuButtonStyle())
                .toolbar { NavigationToolbar(titleText: titleText) }
                .navigationBarBackButtonHidden()

            }
        }.foregroundColor(textColor)
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
            
//            MappingView()
        }
    }
}
