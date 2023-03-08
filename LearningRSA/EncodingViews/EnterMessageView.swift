//
//  EnterMessageView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI

struct MessageFieldView: View {
    
    @FocusState.Binding var focusedField: FocusedField?
    
    @Binding var textFieldMessage: String
    @Binding var inputMessage: String
    @Binding var errorMessage: ErrorMessages
    let maxCharsInMessage = GlobalVars.maxCharsInMessage
    var textStyle = Font.TextStyle.title2
    var minHeight: CGFloat = 100
    var maxHeight: CGFloat = 200
    
    var useNextForSubmitLabel = false
    
    // TODO: Need to test and refactor this function
    func validateText(newValue: String) {
        if textFieldMessage != inputMessage {
            if !newValue.filter({ $0.isNewline }).isEmpty {
                // new line char indicates the user has pressed "done" or "next"
                focusedField = useNextForSubmitLabel ? .prime1 : nil
            }
            else if inputMessage.count >= maxCharsInMessage && newValue.count >= maxCharsInMessage {
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
            .focused($focusedField, equals: .message)
            .font(.system(textStyle, design: .monospaced, weight: .medium))
            .scrollContentBackground(.hidden)
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
            )
            .padding()
            .autocorrectionDisabled()
            .keyboardType(.asciiCapable)
            .submitLabel(useNextForSubmitLabel ? .next : .done)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, minHeight: minHeight, maxHeight: maxHeight)
    }
}

struct EnterMessageView: View {
    @EnvironmentObject var rsa: RSA

    @FocusState private var focusedField: FocusedField?
    
    @State var hideText = false
    @State var textFieldMessage = ""
    @State var errorMessage: ErrorMessages = .noError
    @State var inputMessage = ""
    
    @State var showInfoSheet = false
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
    
    // ask user to try again if something goes wrong
    func resetView() {
        textFieldMessage = ""
        inputMessage = ""
        errorMessage = .miscError
    }
    
    var body: some View {

        VStack {
            NavigationLink(destination: MessageToNumbersView(), isActive: $showNextView) {}
                .isDetailLink(false)
                .toolbar {
                    NavigationToolbar(currentView: .enterMessageView, titleText: "Enter Message")
                }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            ErrorMessageBar(errorMessage: errorMessage)
                .padding(.bottom, 5)
            
            Text("Enter your message here:")
                .font(.system(.title3, design: .monospaced))
            
            MessageFieldView(
                focusedField: $focusedField,
                textFieldMessage: $textFieldMessage,
                inputMessage: $inputMessage,
                errorMessage: $errorMessage)
                   
            if !hideText {
                Text("Keep your message under \(GlobalVars.maxCharsInMessage) characters so that it's easy to understand what's going on.")
                    .padding()
            }
            else {
                ViewThatFits {
                    Text("Keep your message under \(GlobalVars.maxCharsInMessage) characters so that it's easy to understand what's going on.")
                        .padding([.leading, .trailing, .bottom])
                    
                    Text("Keep your message under \(GlobalVars.maxCharsInMessage) characters.")
                        .padding([.leading, .trailing, .bottom])
                }
            }
            
            MoreInfoButton(showInfoSheet: $showInfoSheet, InfoView: EnterMessageInfoView())
                .padding(.bottom)
            
            Button("Convert message to numbers") {
                if finalValidateText() {
                    rsa.inputMessageEng = inputMessage
                    if rsa.stringToNumberConversion() {
                        focusedField = nil
                        showNextView = true
                    }
                    else {
                        resetView()
                    }
                }
            }.purpleButtonStyle()
                .padding()
            
            Spacer()
        }
        .onChange(of: focusedField) {newValue in
            withAnimation {
                hideText = newValue != nil ? true : false
            }
        }
        .monospacedBodyText()
    }
}

struct EnterMessageView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    
    static var previews: some View {
        NavigationView {
            EnterMessageView()
                .environmentObject(rsa)
        }.preferredColorScheme(.dark)
    }
}
