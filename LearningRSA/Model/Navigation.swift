//
//  Navigation.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 1/14/23.
//
//  Contains a list of all the views in the tutorial that will be used to
//  control navigation in the app

//  TODO: To be used to coordinate views with NavigationStack
//  TODO: Need to switch to using this from NavigationView


import SwiftUI

enum ViewNames: String, CaseIterable {
    case welcomeView
    case enterMessageView = "Enter Message"
    case messageToNumbersView = "Convert Message to Numbers"
    case enterEncodePrimesView = "Enter Encoding Primes"
    case generateKeysView = "Create Encryption Key"
    case splitNumbersView = "Split Numbers"
    case encodeMessageView = "Encode Message"
    case enterDecodePrimesView = "Enter Decoding Primes"
    case decodingMathView = "Decoding Overview"
    case privateKeyView = "Create Decryption Key"
    case decodedMessageView = "Decode Message"
    case numbersToTextView = "Convert Numbers to Text"
    case conclusionView = "Conclusion"
    case exploreRSAView
    case exploreRSADecodeView
}

class NavigationController: ObservableObject {
    
    // This will be set to true when the first nav link is pressed
    // Then, setting this to false will pop all the views off the stack
    @Published var rootNavLinkIsActive = false
}


struct Navigation: View {
    var body: some View {
        Text("Test")
        
        //        ZStack {
        //            backgroundColor.ignoresSafeArea()
        //
        //            switch vc.currentView {
        //            case .welcomeView:
        //                WelcomeView()
        //            case .enterMessageView:
        //                EnterMessageView()
        //            case .messageToNumbersView:
        //                MessageToNumbersView()
        //            case .enterEncodePrimesView:
        //                EnterEncodePrimesView()
        //            case .splitNumbersView:
        //                SplitNumbersView()
        //            case .generateKeysView:
        //                GenerateKeysView()
        //            case .encodeMessageView:
        //                EncodeMessageView()
        //            case .enterDecodePrimesView:
        //                EnterDecodePrimesView()
        //            case .decodingMathView:
        //                DecodingMathView()
        //            case .decodedMessageView:
        //                DecodedMessageView()
        //            case .exploreRSAView:
        //                ExploreRSAView()
        //            case .exploreRSADecodeView:
        //                ExploreRSADecodeView()
        //            case .testView: //TODO: Remove after testing
        //                TestView()
        //            case .errorView:
        //                Text("ERROR!")
        //            }
        //        }.foregroundColor(textColor)

    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
    }
}
