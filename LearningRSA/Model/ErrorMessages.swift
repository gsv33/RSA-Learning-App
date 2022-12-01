//
//  ErrorMessages.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 12/1/22.
//

import Foundation

enum ErrorMessages: String {
    case nonASCIIChar = "Please use ASCII characters for your message"
    case maxMessageLength = "Maximum character limit reached"
    case noMessage = "Please enter a message in the text box"
    case noError = ""
    case notPrimes = "Please enter two prime numbers below"
    case success = "Success!"
    case miscError = "Sorry, something went wrong. Please enter your message again."
}
