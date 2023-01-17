//
//  MenuView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 1/13/23.
//

import SwiftUI

struct MenuView: View {
    let title = "RSA Walkthrough"
    let currentView = ViewNames.conclusionView
    
    let encodingViews: [ViewNames] = [.enterMessageView, .messageToNumbersView, .enterEncodePrimesView,
                                  .generateKeysView, .splitNumbersView, .encodeMessageView]
    
    let decodingViews: [ViewNames] = [.enterDecodePrimesView, .decodingMathView, .privateKeyView,
                                      .decodedMessageView, .numbersToTextView, .conclusionView]

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navigationController: NavigationController
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                Text(title)
                    .monospacedTitleText(textStyle: .title2)
                    .padding()

                Text("Encoding Steps")
                    .font(.system(.title3, design: .monospaced))
                    .foregroundColor(Colors.inputColor)

                ForEach(encodingViews, id: \.rawValue) {viewName in
                    Text(viewName.rawValue)
                        .foregroundColor(viewName == currentView ? Colors.outputColor : .white)
                        .padding(1)
                }
                
                Divider()
                    .frame(height: 1)
                    .overlay(.white)
                    .padding()

                Text("Decoding Steps")
                    .font(.system(.title3, design: .monospaced))
                    .foregroundColor(Colors.inputColor)

                ForEach(decodingViews, id: \.rawValue) {viewName in
                    Text(viewName.rawValue)
                        .foregroundColor(viewName == currentView ? Colors.outputColor : .white)
                        .padding(1)
                }

                Button("Back to Welcome Screen") {
                    navigationController.rootNavLinkIsActive = false
//                    dismiss()
                }
                .buttonStyle(MenuButtonStyle())
                .padding()
                
                Button("Dismiss Menu") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
                
            }.monospacedBodyText()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    @StateObject static var navigationController = NavigationController()
    
    static var previews: some View {
        MenuView()
            .environmentObject(navigationController)
    }
}
