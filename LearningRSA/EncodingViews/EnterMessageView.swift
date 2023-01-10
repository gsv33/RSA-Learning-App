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
    let maxCharsInMessage = GlobalVars.maxCharsInMessage
    var textStyle = Font.TextStyle.title2
    
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

        TextEditor(text: $textFieldMessage)
            .onChange(of: textFieldMessage) { newValue in
                validateText(newValue: newValue)
            }
            .font(.system(textStyle, design: .monospaced, weight: .medium))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 10)
            )
            .padding()
            .autocorrectionDisabled()
            .keyboardType(.asciiCapable)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, maxHeight: 200)
    }
}

struct EnterMessageView: View {
    @EnvironmentObject var rsa: RSA

    @State var textFieldMessage = "THIS"
    @State var errorMessage: ErrorMessages = .noError
    @State var inputMessage = "THIS"
    
    @State var showNextView = false
        
    func finalValidateText() -> Bool {
        // make sure message does not exceed limit
        if inputMessage.count == 0 {
            errorMessage = .noMessage
            return false
        }

        // TODO: Should never happen, throw an error here
        if inputMessage.count > GlobalVars.maxCharsInMessage {
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
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: MessageToNumbersView(), isActive: $showNextView) {}
                .toolbar { NavigationToolbar(titleText: "Enter Message") }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack {
                ErrorMessageBar(errorMessage: errorMessage)
                    .padding(.bottom, 5)
                
                Text("Enter your message here:")
                    .font(.system(.title3, design: .monospaced))
                
                MessageFieldView(
                    textFieldMessage: $textFieldMessage,
                    inputMessage: $inputMessage,
                    errorMessage: $errorMessage)
                .padding(.bottom, 10)
                                
                Button("Convert message to numbers") {
                    if finalValidateText() {
                        rsa.inputMessageEng = inputMessage
                        rsa.stringToNumberConversion()
                        showNextView = true
                        
                    }
                    else {
                        //TODO: Reload view if something goes wrong
                    }
                }.buttonStyle(MenuButtonStyle())
                
                Text("You'll have to keep your message under 50 characters so that it's easy to understand what's going on.").padding()
            }
        }.monospacedBodyText()
    }
}

struct EnterMessageView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    
    static var previews: some View {
        NavigationView {
            EnterMessageView()
                .environmentObject(rsa)
        }
    }
}
