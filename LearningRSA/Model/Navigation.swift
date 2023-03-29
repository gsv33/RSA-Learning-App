//
//  Navigation.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 1/14/23.
//
//  Contains a list of all the views in the tutorial that will be used to
//  control navigation in the app

//  TODO: Need to switch to NavigationStack from NavigationView


import SwiftUI

enum ViewNames: String, CaseIterable {
    case welcomeView
    case enterMessageView = "Enter Message"
    case messageToNumbersView = "Number Conversion"
    case enterEncodePrimesView = "Prime Numbers"
    case generateKeysView = "Encryption Key"
    case splitNumbersView = "Split Numbers"
    case encodeMessageView = "Message Encoding"
    case enterDecodePrimesView = "Decoding Primes"
    case decodingMathView = "Decoding Equation"
    case privateKeyView = "Decryption Key"
    case decodedMessageView = "Message Decoding"
    case numbersToTextView = "Numbers to Text"
    case conclusionView = "Next Steps"
    case exploreRSAView
    case exploreRSADecodeView
}

class NavigationController: ObservableObject {
    
    // This will be set to true when the first nav link is pressed
    // Then, setting this to false will pop all the views off the stack
    @Published var tutorialNavLinkIsActive = false
    @Published var exploreNavLinkIsActive = false
    
    func popToRootFromTutorial() {
        if tutorialNavLinkIsActive {
            tutorialNavLinkIsActive = false
        }
    }
    
    func popToRootFromExploreRSA() {
        if exploreNavLinkIsActive {
            exploreNavLinkIsActive = false
        }
    }
}
