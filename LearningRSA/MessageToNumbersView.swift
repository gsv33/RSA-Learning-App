//
//  MessageToNumbersView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI


struct MessageToNumbersView: View {
    @EnvironmentObject var rsa: RSA
    
    var body: some View {
        let maxDigitsInNum = String(rsa.productOfPrimes).count
        
//        var i = 0
//        var listMessage = "" // substring of entire message with < mDigits
//        for c in inputString {
//            if let num = charToNumEncoding[c] {
//                inputMessage += "\(num)"
//
//                for n in String(num) {
//                    listMessage.append(n)
//                    if listMessage.count == mDigits - 1 {
//                        inputMessageList.append(Int(listMessage)!)
//                        listMessage = ""
//                    }
//                }
//            }
//            else {
//                print("ERROR. INVALID CHARACTER ENTERED.")
//            }
//        }

        
        Text(rsa.inputMessage)
    }
}

//struct MessageToNumbersView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageToNumbersView()
//    }
//}
