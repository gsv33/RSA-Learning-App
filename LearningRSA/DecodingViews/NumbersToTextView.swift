//
//  NumbersToTextView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/2/22.
//

import SwiftUI

struct NumbersToTextView: View {
    @EnvironmentObject var rsa: RSA
    
    var body: some View {
        Text("Hello world!")
//        Text(rsa.decodedMessageStr)
    }
}

//struct NumbersToTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        NumbersToTextView()
//    }
//}
