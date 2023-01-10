//
//  SplitNumbersView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/31/22.
//

import SwiftUI

struct SplitNumbersView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    let titleText = "Split Numbers"
    
    @State var showInfoPopover = false
    @State var showNextView = false

    @State var elapsedTime = 0
    @State var textOpacity1 = 0.0
    @State var textOpacity2 = 0.0
    @State var textOpacity3 = 0.0
    @State var textOpacity4 = 0.0
    
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
                    } else if elapsedTime == 14 {
                        textOpacity4 = 1.0
                    }
                }
            
            NavigationLink(destination: EncodeMessageView(), isActive: $showNextView) {}
                .toolbar { NavigationToolbar(titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack{
                Group {
                    Text("Your message: \n") +
                    Text("\(rsa.inputMessageEng)\n").foregroundColor(Colors.outputColor)
                    
                    
                    Text("Your message in numbers:\n") +
                    Text("\(rsa.inputMessageNum)\n").foregroundColor(Colors.outputColor)
                    
                    
                    Text("Your public key:\n ") +
                    Text("\(String(rsa.encodePhi))").foregroundColor(Colors.outputColor) +
                    Text("-") +
                    Text("\(String(rsa.encryptionKeyE))").foregroundColor(Colors.outputColor)
                }
                .onAppear { textOpacity1 = 1.0 }
                .opacity(textOpacity1)
                .animation(.easeIn(duration: 1.0), value: textOpacity1)

                Group {
                    Text("Before we can convert your message, we need to split it up into pieces smaller than the product of your two primes. This lets us properly apply the mathematical transformation to secures the message.").padding()
                }
                .opacity(textOpacity2)
                .animation(.easeIn(duration: 1.0), value: textOpacity2)
                    
                
                Text("Here is your new message:")
                    .opacity(textOpacity3)
                    .animation(.easeIn(duration: 1.0), value: textOpacity3)
                
                HStack{
                    ForEach(rsa.inputMessageNumList) { number in
                        Text(number.value).foregroundColor(Colors.outputColor)
                    }
                }
                .opacity(textOpacity3)
                .animation(.easeIn(duration: 1.0).delay(1), value: textOpacity3)

                Text("Now, we are finally ready to encode your message.")
                    .padding()
                    .opacity(textOpacity4)
                    .animation(.easeIn(duration: 1.0), value: textOpacity4)
                           
                Group {
                    MoreInfoButton(
                        showInfoPopover: $showInfoPopover,
                        InfoView: SplitNumbersInfoView()
                    )
                    
                    Button("Encode Message") {
                        rsa.encodeMessage()
                        showNextView = true
                    }
                    .buttonStyle(GenerateRandomPrimesButtonStyle())
                    .padding()
                }
                .opacity(textOpacity4)
                .animation(.easeIn(duration: 1.0).delay(1), value: textOpacity4)
            }
            .monospacedBodyText()
        }
    }
}

struct SplitNumbersView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        NavigationView {
            SplitNumbersView()
                .environmentObject(rsa)
                .environmentObject(vc)
        }

    }
}
