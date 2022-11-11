//
//  ContentView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/27/22.
//

import SwiftUI

class ViewCoordinator: ObservableObject {
    @Published var currentView = 0
}

let backgroundColor = Color.black
let textColor = Color.green

struct ContentView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    var body: some View {
        
        // TODO: Switch numbered cases to enum
        switch vc.currentView {
        case 0:
            WelcomeView()
        case 1:
            EnterMessageView()
        case 2:
            MessageToNumbersView()
        case 3:
            EnterEncodePrimesView()
        case 4:
            SplitNumbersView()
        case 5:
            GenerateKeysView()
        case 6:
            EncodeMessageView()
        case 7:
            EnterDecodePrimesView()
        case 8:
            DecodingMathView()
        case 9:
            DecodedMessageView()
        case 10:
            NumbersToTextView()
        default:
            Text("ERROR!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()
    
    static var previews: some View {
        ContentView()
            .environmentObject(rsa)
            .environmentObject(vc)
    }
}
