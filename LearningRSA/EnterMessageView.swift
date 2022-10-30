//
//  EnterMessageView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI

struct EnterMessageView: View {
    @EnvironmentObject var rsa: RSA
    
    var body: some View {
        VStack {
            TextField("Enter your message", text: $rsa.inputMessage)
                .padding()
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
