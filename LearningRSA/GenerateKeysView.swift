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
        Text("Public Key K: " + String(rsa.publickeyK))
    }
}

//struct GenerateKeysView_Previews: PreviewProvider {
//    static var previews: some View {
//        GenerateKeysView()
//    }
//}
