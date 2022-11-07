//
//  MessageToNumbersView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI


struct MessageToNumbersView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    var body: some View {
        
        VStack{
            Text(rsa.inputMessageStr)
            Text(rsa.inputMessageNum)

            Button("Enter primes to encode") {
                vc.currentView = 3
            }            
        }
    }
}

//struct MessageToNumbersView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageToNumbersView()
//    }
//}
