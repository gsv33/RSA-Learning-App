//
//  ContentView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/27/22.
//

import SwiftUI

enum ViewNames {
    case welcomeView
    case enterMessageView
    case messageToNumbersView
    case enterEncodePrimesView
    case splitNumbersView
    case generateKeysView
    case encodeMessageView
    case enterDecodePrimesView
    case decodingMathView
    case decodedMessageView
    case numbersToTextView
    case errorView
}

class ViewCoordinator: ObservableObject {
    @Published var currentView = ViewNames.welcomeView
}

let backgroundColor = Color.black
let textColor = Color.green

struct ContentView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    var body: some View {
        
        switch vc.currentView {
        case .welcomeView:
            WelcomeView()
        case .enterMessageView:
            EnterMessageView()
        case .messageToNumbersView:
            MessageToNumbersView()
        case .enterEncodePrimesView:
            EnterEncodePrimesView()
        case .splitNumbersView:
            SplitNumbersView()
        case .generateKeysView:
            GenerateKeysView()
        case .encodeMessageView:
            EncodeMessageView()
        case .enterDecodePrimesView:
            EnterDecodePrimesView()
        case .decodingMathView:
            DecodingMathView()
        case .decodedMessageView:
            DecodedMessageView()
        case .numbersToTextView:
            NumbersToTextView()
        case .errorView:
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
