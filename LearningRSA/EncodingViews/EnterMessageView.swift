//
//  EnterMessageView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI

enum ErrorMessages: String {
    case nonASCIIChar = "Please use ASCII characters for your message"
    case maxMessageLength = "You have reached the maximum number of characters allowed for your message"
    case noError = ""
    case success = "Success!"
    case miscError = "Sorry, something went wrong. Please enter your message again."
}

struct EnterMessageView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    //TODO: Modify max character limit for the message
    let maxCharsInMessage = 5
    @State var inputMessage = ""
    @State var tempMessage = ""
    @State var errorMessage = ErrorMessages.noError
    
    // TODO: Need to test and refactor this function
    func validateText(newValue: String) {
        if tempMessage != inputMessage {
            if inputMessage.count >= maxCharsInMessage && newValue.count >= maxCharsInMessage {
                errorMessage = .maxMessageLength
            }
            else {
                tempMessage = newValue.filter { $0.isASCII }
                if tempMessage.count != newValue.count {
                    errorMessage = .nonASCIIChar
                }
                else {
                    if tempMessage.count > maxCharsInMessage {
                        errorMessage = .maxMessageLength
                        tempMessage = String(tempMessage.prefix(maxCharsInMessage))
                    }
                    else {
                        errorMessage = .noError
                    }
                    inputMessage = tempMessage
                }
            }
            
            tempMessage = inputMessage
        }
    }
    
    func finalValidateText() -> Bool {
        // make sure message does not exceed limit
        if inputMessage.count <= 0 {
            return false
        }
        if inputMessage.count > maxCharsInMessage {
            return false
        }
        
        // make sure each char is ASCII
        for char in inputMessage {
            if !char.isASCII {
                return false
            }
        }
        
        return true
    }
    
    var body: some View {
        VStack {
            Text(errorMessage.rawValue)
                .foregroundColor(errorMessage == .success ? Color.green : Color.red)
                .padding()
                .bold()
            
            Text("First, Enter your message here:")
            
            // TODO: Make sure textfield has restricted input
            TextField("", text: $tempMessage)
                .onChange(of: tempMessage) { newValue in
                    validateText(newValue: newValue)
                }
                .padding()
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
                .bold()
                .keyboardType(.asciiCapable)
                
            
            Button("Convert message to numbers") {
                if finalValidateText() {
                    rsa.inputMessageEng = inputMessage
                    rsa.stringToNumberConversion()
                    vc.currentView = .messageToNumbersView
                }
                else {
                    errorMessage = .miscError
                    tempMessage = ""
                    inputMessage = ""
                }
            }
        }
        .onAppear { // TODO: For testing purposes only, need to remove
            print("Input String is: \(rsa.inputMessageEng)")
            rsa.stringToNumberConversion()
            print("Input Number is: \(rsa.inputMessageNum)")
            rsa.computeProductOfPrimes()
            rsa.splitInputNumberByDigits()
            for i in rsa.inputMessageNumList {
                print("Split digits are: \(i.value)")
            }
            try! rsa.computePublicKeyK()
            print("K: \(rsa.publicKeyK)")
            print("P1: \(rsa.prime1), P2: \(rsa.prime2), M: \(rsa.productOfPrimes)")
            rsa.encodeMessage()
            for i in rsa.encodedMessageNumList {
                print("Encoded message is: \(i.value)")
            }
            print("Encoded message str: \(rsa.encodedMessageNum)")
            
            rsa.computeInvPublicKeys()
            print("Real Inv Key: \(rsa.realInvPublicKeyK)")
            print("Fake Inv Key: \(rsa.fakeInvPublicKeyK)")

            rsa.decodeRealAndFakeMessages()
            for i in rsa.realDecodedMessageNumList {
                print("Real decoded message: \(i.value)")
            }
            print("Real decoded message: \(rsa.realDecodedMessageNum)")
            
            print("")
            for i in rsa.fakeDecodedMessageNumList {
                print("Fake decoded message: \(i.value)")
            }
            print("Fake decoded message: \(rsa.fakeDecodedMessageNum)")
            
            print("Done.")
            
            // Looks good so far!
        }
    }
}

struct EnterMessageView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        EnterMessageView()
            .environmentObject(rsa)
            .environmentObject(vc)
    }
}
