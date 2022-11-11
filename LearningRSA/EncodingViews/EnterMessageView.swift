//
//  EnterMessageView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI

struct EnterMessageView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    var body: some View {
        VStack {
            Text("First, Enter your message here:")
            
            // TODO: Make sure textfield has restricted input
            TextField("", text: $rsa.inputMessageStr)
                .padding()
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
                .bold()
            
            Button("Convert message to numbers") {
                rsa.stringToNumberConversion()
                vc.currentView = 2
            }
        }
    }
}

struct EnterMessageView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        EnterMessageView()
            .environmentObject(rsa)
            .environmentObject(vc)
    }
}
