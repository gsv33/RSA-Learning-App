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
            TextField("Enter your message", text: $rsa.inputMessageStr)
                .padding()

            Button("Convert message to numbers") {
                rsa.stringToNumberConversion()
                vc.currentView = 2
            }
        }
    }
}

//struct EnterMessageView_Previews: PreviewProvider {
//    @State static var message: String = ""
//    
//    static var previews: some View {
//        EnterMessageView(message: $message)
//    }
//}
