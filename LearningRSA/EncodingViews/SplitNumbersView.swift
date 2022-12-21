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

    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack{
                Group {
                    Text("Your Message: \(rsa.inputMessageEng)")
                    Text("Your Message in Numbers: \(rsa.inputMessageNum)")
                    Text("Your prime numbers: \(String(rsa.prime1)) and \(String(rsa.prime2)). ").bold()
                }
                Text("Now let's split your numbers up into smaller pieces that are easier to manage").padding()
                HStack{
                    ForEach(rsa.inputMessageNumList) { number in
                        Text(number.value)
                    }
                }
                
                Button(action: {
                    showInfoPopover = true
                }) {
                    Label("More Info", systemImage: "info.square")
                }
                .popover(isPresented: $showInfoPopover) { SplitNumbersInfoView() }
                .monospacedBodyText()
                .padding()
                
                NavigationLink(destination: GenerateKeysView(), isActive: $showNextView) {}
                    .toolbar { NavigationToolbar(titleText: titleText) }
                    .navigationBarBackButtonHidden()
                    .navigationBarTitleDisplayMode(.inline)

                
                Button("Encode Message") {
                    rsa.encodeMessage()
                }
                .buttonStyle(GenerateRandomPrimesButtonStyle())
            }.foregroundColor(.white)
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
