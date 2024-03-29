//
//  ErrorMessages.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 12/1/22.
//

import Foundation
import SwiftUI

enum ErrorMessages: String {
    case nonASCIIChar = "Please use ASCII characters for your message"
    case maxMessageLength = "Maximum character limit reached"
    case noMessage = "Please enter a message in the text box"
    case noError = "No error"
    case notPrimes = "Enter two prime numbers below"
    case success = "Success!"
    case miscError = "Error. Please enter your message again."
    case encodeMessage = "Please encode a message first!"
    case primesMatch = "Prime numbers must be different"
    case primesLimitReached = "Primes must be 4 digits or less"
    case notNumber = "Please enter a number"
    case productUnder2Digits = "Product of your primes must be at least 2 digits"
}

// Text displaying the current error message across the app's views
struct ErrorMessageBar: View {
    
    var errorMessage: ErrorMessages
    
    var body: some View {
        Text(errorMessage.rawValue)
            .opacity(errorMessage == ErrorMessages.noError ? 0.0 : 1.0)
            .padding([.leading, .trailing])
            .foregroundColor(errorMessage == .success ? Color.green : Color.red)
            .font(.system(.body, design: .monospaced, weight: .semibold))
    }
}
