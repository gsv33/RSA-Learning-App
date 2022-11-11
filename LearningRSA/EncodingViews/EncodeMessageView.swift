//
//  EncodeMessageView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/1/22.
//

import SwiftUI

struct EncodeMessageView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    var body: some View {
        VStack{
            ForEach(rsa.encodedMessageList) { number in
                Text(String(number.value))
            }
            
            Button("Start decoding") {
                vc.currentView = 7
            }
        }
    }
}

//struct EncodeMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        EncodeMessageView()
//    }
//}
