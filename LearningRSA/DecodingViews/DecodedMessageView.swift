//
//  DecodedMessageView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/2/22.
//

import SwiftUI

// Displays the final message of both the fake and real text

struct DecodedMessageView: View {
    @EnvironmentObject var rsa: RSA
    
    var body: some View {
        Text("Display the messages!!!!")
        
//        VStack{
//            ForEach(rsa.decodedMessageList) { number in
//                Text(String(number.value))
//            }
//            Text(rsa.decodedMessageNum)
//        }
    }
}


struct DecodedMessageView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        DecodedMessageView()
            .environmentObject(rsa)
            .environmentObject(vc)
    }
}
