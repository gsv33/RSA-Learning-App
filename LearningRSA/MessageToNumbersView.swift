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
        
        VStack{
            Text(rsa.inputMessageStr)
            Text(rsa.inputMessageNum)
        }
    }
}

//struct MessageToNumbersView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageToNumbersView()
//    }
//}
