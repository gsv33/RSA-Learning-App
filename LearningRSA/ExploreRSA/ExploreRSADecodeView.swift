//
//  ExploreRSADecodeView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/30/22.
//

import SwiftUI

struct ExploreRSADecodeView: View {
    
    var prime1: Int = 0
    var prime2: Int = 0
    
    @State var encodedMessage: String = "TEST MESSAGE"
    
    var body: some View {
        HStack{
            Button("BACK") {}
            Spacer()
        }
        
        TextField("EncodedMessage", text: $encodedMessage)
    }
}

struct ExploreRSADecodeView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        ExploreRSADecodeView()
    }
}
