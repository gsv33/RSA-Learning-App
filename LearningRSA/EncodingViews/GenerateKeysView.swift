//
//  GenerateKeysView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/1/22.
//

import SwiftUI

struct GenerateKeysView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    var body: some View {
        VStack {
            Text("Public Key K: " + String(rsa.publicKeyK))
            
            Button("Encode message", action: {
                rsa.encodeMessage()
                vc.currentView = 6
            })
        }
    }
}

//struct GenerateKeysView_Previews: PreviewProvider {
//    static var previews: some View {
//        GenerateKeysView()
//    }
//}
