//
//  GenerateKeysView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/1/22.
//

import SwiftUI

struct GenerateKeysView: View {
    @EnvironmentObject var rsa: RSA
    
    var body: some View {
        VStack {
            Text("Public Key K: " + String(rsa.publicKeyK))
            
            Button("Encode message", action: {
                rsa.encodeMessage()
            })
        }
    }
}

//struct GenerateKeysView_Previews: PreviewProvider {
//    static var previews: some View {
//        GenerateKeysView()
//    }
//}
