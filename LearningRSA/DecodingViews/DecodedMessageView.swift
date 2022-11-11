//
//  DecodedMessageView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/2/22.
//

import SwiftUI

struct DecodedMessageView: View {
    @EnvironmentObject var rsa: RSA
    
    var body: some View {
        VStack{
            ForEach(rsa.decodedMessageList) { number in
                Text(String(number.value))
            }
            Text(rsa.decodedMessageNum)
        }
    }
}

//struct DecodedMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        DecodedMessageView()
//    }
//}
