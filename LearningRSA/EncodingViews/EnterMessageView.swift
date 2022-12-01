//
//  EnterMessageView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI

struct MessageFieldView: View {
    
    //TODO: Modify max character limit for the message
    @Binding var textFieldMessage: String
    @Binding var inputMessage: String
    @Binding var errorMessage: ErrorMessages
    let maxCharsInMessage: Int

    // TODO: Need to test and refactor this function
    func validateText(newValue: String) {
        if textFieldMessage != inputMessage {
            if inputMessage.count >= maxCharsInMessage && newValue.count >= maxCharsInMessage {
                errorMessage = .maxMessageLength
            }
            else {
                textFieldMessage = newValue.filter { $0.isASCII }
                if textFieldMessage.count != newValue.count {
                    errorMessage = .nonASCIIChar
                }
                else {
                    if textFieldMessage.count > maxCharsInMessage {
                        errorMessage = .maxMessageLength
                        textFieldMessage = String(textFieldMessage.prefix(maxCharsInMessage))
                    }
                    else {
                        errorMessage = .noError
                    }
                    inputMessage = textFieldMessage
                }
            }
            
            textFieldMessage = inputMessage
        }
    }
    
    var body: some View {
        TextField("Enter message here", text: $textFieldMessage, axis: .vertical)
            .onChange(of: textFieldMessage) { newValue in
                validateText(newValue: newValue)
            }
            .padding()
            .autocorrectionDisabled()
            .textFieldStyle(.roundedBorder)
            .font(.system(.title2, design: .monospaced, weight: .medium))
            .keyboardType(.asciiCapable)
    }
}

struct EnterMessageView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator

    @State var textFieldMessage = "THIS IS A TEST"
    @State var errorMessage: ErrorMessages = .noError
    @State var inputMessage = ""
    
    let maxCharsInMessage = 15
    
    func finalValidateText() -> Bool {
        // make sure message does not exceed limit
        if inputMessage.count == 0 {
            errorMessage = .noMessage
            return false
        }

        // TODO: Should never happen, throw an error here
        if inputMessage.count > maxCharsInMessage {
            // TODO
            return false
        }
        
        // Should never happen, throw an error here
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
            
            MessageFieldView(
                textFieldMessage: $textFieldMessage,
                inputMessage: $inputMessage,
                errorMessage: $errorMessage,
                maxCharsInMessage: maxCharsInMessage)
            
            Button("Convert message to numbers") {
                if finalValidateText() {
                    rsa.inputMessageEng = inputMessage
                    rsa.stringToNumberConversion()
                    vc.currentView = .messageToNumbersView
                }
                else {
                    //TODO: Reload view if something goes wrong
                }
            }
        }
        .onAppear { // TODO: For testing purposes only, need to remove
//            print("Input String is: \(rsa.inputMessageEng)")
//            rsa.stringToNumberConversion()
//            print("Input Number is: \(rsa.inputMessageNum)")
//            rsa.computeProductOfPrimes()
//            rsa.splitInputNumberByDigits()
//            for i in rsa.inputMessageNumList {
//                print("Split digits are: \(i.value)")
//            }
//            try! rsa.computePublicKeyK()
//            print("K: \(rsa.publicKeyK)")
//            print("P1: \(rsa.prime1), P2: \(rsa.prime2), M: \(rsa.productOfPrimes)")
//            rsa.encodeMessage()
//            for i in rsa.encodedMessageNumList {
//                print("Encoded message is: \(i.value)")
//            }
//            print("Encoded message str: \(rsa.encodedMessageNum)")
//
//            rsa.computeInvPublicKeys()
//            print("Real Inv Key: \(rsa.realInvPublicKeyK)")
//            print("Fake Inv Key: \(rsa.fakeInvPublicKeyK)")
//
//            rsa.decodeRealAndFakeMessages()
//            for i in rsa.realDecodedMessageNumList {
//                print("Real decoded message: \(i.value)")
//            }
//            print("Real decoded message: \(rsa.realDecodedMessageNum)")
//
//            print("")
//            for i in rsa.fakeDecodedMessageNumList {
//                print("Fake decoded message: \(i.value)")
//            }
//            print("Fake decoded message: \(rsa.fakeDecodedMessageNum)")
//
//            rsa.convertDecodedMessagesToEnglish()
//            print("Fake english: \(rsa.fakeDecodedMessageEng)")
//            print("Real english: \(rsa.realDecodedMessageEng)")
//
//            print("Done.")
//
            // Looks good so far!
        }
    }
}

struct EnterMessageView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()
    @State static var errorMessage: ErrorMessages = .noError
    
    static var previews: some View {
//        MessageFieldView(errorMessage: $errorMessage)
        
        EnterMessageView()
            .environmentObject(rsa)
            .environmentObject(vc)
    }
}
